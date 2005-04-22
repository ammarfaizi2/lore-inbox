Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVDVAvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVDVAvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVDVAvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:51:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:40426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261893AbVDVAvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:51:41 -0400
Date: Thu, 21 Apr 2005 17:25:34 -0700
From: Greg KH <greg@kroah.com>
To: Shaun Jackman <sjackman@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: lirc and Linux 2.6.11
Message-ID: <20050422002533.GA6829@kroah.com>
References: <7f45d9390504211526277e83be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390504211526277e83be@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 03:26:37PM -0700, Shaun Jackman wrote:
> I was using lirc 0.7.0 with Linux 2.6.8.1. Upon upgrading to Linux
> 2.6.11, I recompiled the lirc 0.7.0 hauppauge (lirc_i2c) modules for
> the new kernel. This did not work. I then tried compiling the lirc
> 0.7.1 modules for the new kernel. This didn't work either. The error
> message lircd gives is...
> 
> Apr 21 14:57:29 quince lircd 0.7.1: lircd(hauppauge) ready
> Apr 21 14:57:52 quince lircd 0.7.1: accepted new client on /dev/lircd
> Apr 21 14:57:52 quince lircd 0.7.1: could not open /dev/lirc0
> Apr 21 14:57:52 quince lircd 0.7.1: default_init(): No such device
> Apr 21 14:57:52 quince lircd 0.7.1: caught signal
> 
> I've also asked the lirc mailing list this question, but has anyone
> else run into this trouble with lirc and Linux 2.6.11?

As the lirc developers have no intention of ever merging with the
mainline kernel code, you will have to ask all lirc questions to them,
we can not help you out at all, sorry.

thanks,

greg k-h
