Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWGANBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWGANBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 09:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWGANBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 09:01:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43663 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751176AbWGANBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 09:01:32 -0400
Subject: Re: RFC: unlazy fpu for frequent fpu users
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ada7j2ye0mv.fsf@cisco.com>
References: <1151705536.11434.69.camel@laptopd505.fenrus.org>
	 <ada7j2ye0mv.fsf@cisco.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 15:01:29 +0200
Message-Id: <1151758889.3195.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 15:31 -0700, Roland Dreier wrote:
>  > +	/* prefetch the fxsave area into the cache */
>  > +	prefetch(&next->i387.fxsave);
> 
> This chunk is not obviously related to the rest of the patch, and
> perhaps needs additional justification.

ok fair enough; will improve the comment

