Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270596AbTGUQ5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270586AbTGUQzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:55:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:26559 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270623AbTGUQx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:53:27 -0400
Date: Mon, 21 Jul 2003 12:44:32 -0400
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ole.rohne@cern.ch
Subject: Re: More powermanagment hooks for pci
Message-ID: <20030721164432.GA10931@kroah.com>
References: <20030720212943.GA724@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720212943.GA724@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 11:29:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> Apparently, some pci driver (8390too) need to do something at poweron
> before interrupts are enabled. Please apply,

Sorry, but I'm not going to apply this.  I'm pretty sure that Pat has
some changes like this pending in his power management stuff, that I
think we should wait for.

And yes, I have the same laptop that would benifit from this patch, but
a change like this for just one driver isn't ok.

thanks,

greg k-h
