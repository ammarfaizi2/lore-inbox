Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTL1TxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 14:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTL1TxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 14:53:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43531 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261974AbTL1Twy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 14:52:54 -0500
Date: Sun, 28 Dec 2003 19:52:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] fix use-after-free in ds.c
Message-ID: <20031228195251.C20278@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200312281852.01685.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200312281852.01685.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Sun, Dec 28, 2003 at 06:52:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 06:52:01PM +0100, Daniel Ritz wrote:
> this is russell king's patch from october plus removes some unused vars.

Note that they're only unused if you don't enable debugging.

> against 2.6.0, please enqueue.

I think my original patch is already queued, but unfortunately 2.6
isn't going anywhere just yet.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
