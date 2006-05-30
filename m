Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWE3VB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWE3VB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWE3VB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:01:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11435 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932424AbWE3VB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:01:28 -0400
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <adawtc35iws.fsf@cisco.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu>
	 <ada1wub6y6b.fsf@cisco.com> <20060530204901.GA27645@elte.hu>
	 <adawtc35iws.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 23:01:20 +0200
Message-Id: <1149022880.3636.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 13:58 -0700, Roland Dreier wrote:
> Thanks, that boots.
> 
> During boot I see this, apparently while mounting NFS filesystems:


do you have KALLSYMS_ALL enabled? This looks like a thing we already
fixed as well... but it also looks a bit odd ..

