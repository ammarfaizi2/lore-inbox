Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbUABUXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUABUXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:23:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:38533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265653AbUABUXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:23:37 -0500
Date: Fri, 2 Jan 2004 12:21:25 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-ID: <20040102202125.GC4992@kroah.com>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org> <20040102123636.GA29909@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102123636.GA29909@mark.mielke.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 07:36:36AM -0500, Mark Mielke wrote:
> 
> Personally, I like the idea of having a clean /dev where names only
> exist for devices that I care about. On my Fedora Core 1 box, it looks
> like /dev is currently:
> 
>     $ ls /dev | wc -l
>        7528
> 
> Seven *THOUSAND* five hundred and twenty eight. Sheesh. I probably only
> use a few dozen, or maybe even a few hundred, but definately not 7000+.

You missed all of the subdirectories.  Here's what FC-1 has on my laptop:
	$ tree /dev/ | tail -1
	41 directories, 18721 files

thanks,

greg k-h
