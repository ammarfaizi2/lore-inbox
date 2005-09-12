Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVILE7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVILE7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 00:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVILE7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 00:59:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:15077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751099AbVILE67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 00:58:59 -0400
Date: Sun, 11 Sep 2005 21:58:34 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/char/isicom old api rewritten (round 3)
Message-ID: <20050912045834.GA18780@kroah.com>
References: <20050911152045.7ca42491.akpm@osdl.org> <200509112311.j8BNB0sA016447@wscnet.wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509112311.j8BNB0sA016447@wscnet.wsc.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 01:11:00AM +0200, Jiri Slaby wrote:
> > > >40k isn't large - please include such patches in the email.
> > > >
> > > Thank you, Andrew, for your reply and hints, you sent.
> > Did everything get addressed?
> Maybe not, if you still want it in e-mail as plaintext, grr.
> 
> > Then send the patch, cc'ed to the mailing list as per
> > http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.
> Oops, I read only SubmittingPatches. So this file should be changed in point 7
> (that not everybody wants URLs).
> 
> 
> 
> This patch removes old api in pci probing and replaces it with new. Firmware
> loading added.

You do a lot of different things in this patch (whitespace changes, line
wrapps, etc.)  Try a few patches in order (coding style issues, then pci
api, then firmware, etc.)

thanks,

greg k-h
