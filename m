Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWARHNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWARHNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWARHNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:13:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8411 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964899AbWARHNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:13:14 -0500
Subject: Re: [PATCH] pepoll_wait ...
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20060117210318.1f4212f0.akpm@osdl.org>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
	 <43CDC21C.7050608@redhat.com>  <20060117210318.1f4212f0.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 18:13:11 +1100
Message-Id: <1137568391.30084.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 21:03 -0800, Andrew Morton wrote:
> It seems that the preferred way to fix this is to sprinkle #ifdef
> TIF_RESTORE_SIGMASK all over the code.

That's intended to be a temporary 'fix' until all the other
architectures catch up. I don't want it there long-term.

-- 
dwmw2

