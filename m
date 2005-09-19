Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbVISXbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbVISXbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 19:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVISXbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 19:31:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43398 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932648AbVISXbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 19:31:13 -0400
Date: Tue, 20 Sep 2005 00:31:04 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: linux-fbdev-devel@lists.sourceforge.net
cc: Jan Dittmer <jdittmer@ppp0.net>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: no cursor on nvidiafb console in
 2.6.14-rc1-mm1
In-Reply-To: <432F36B4.8030209@gmail.com>
Message-ID: <Pine.LNX.4.56.0509200030280.611@pentafluge.infradead.org>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net>
 <432F36B4.8030209@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the hwcur module parameter is set to off by default. Should it be removed?

On Tue, 20 Sep 2005, Antonino A. Daplas wrote:

> Jan Dittmer wrote:
> > jurriaan wrote:
> >> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
> >> my console.
> > 
> > Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
> > sorry. No fb options on the kernel command line.
> > 
> 
> Can you try reversing this particular diff?
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a
> 
> Tony
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
