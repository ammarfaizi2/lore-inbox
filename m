Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTIZSWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIZSWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:22:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:60880 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261539AbTIZSWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:22:35 -0400
Date: Fri, 26 Sep 2003 11:22:29 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?B=F6rkur_Ingi_J=F3nsson?= <bugsy@isl.is>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Message-ID: <20030926182229.GA17041@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <200309261724.56616.bugsy@isl.is> <20030926180327.GA5204@kroah.com> <200309261827.28606.bugsy@isl.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309261827.28606.bugsy@isl.is>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 06:27:28PM +0000, Börkur Ingi Jónsson wrote:
>  Friday 26 September 2003 18:03, you wrote:
> > On Fri, Sep 26, 2003 at 05:24:56PM +0000, Börkur Ingi Jónsson wrote:
> > > Ps. in english this means that. On my computer khubd is using 100% of my
> > > cpu... any fix on this?
> >
> > As I asked for in your bugzilla.kernel.org filing, what does the kernel
> > log showing?  Is there lots of USB activity?  Are there any USB devices
> > plugged into the system?  Does this also happen for 2.4?  Are you using
> > ACPI?  (I can go on, but that's a good start.  You need to provide a
> > much better bug report than this...)
> >
> > greg k-h
> Ok Hi, 
> 
> I sent an earlier email ( 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0409.html )
> asking what kind of info dev's wanted for a report and where I could get it. 
> 
> 1. Where can I find the kernel log?

Run 'dmesg'

> 2. I have a usb keyboard plugged in It's packard Bell model number 9201
> 
> 3. This did not happen with 2.4
> 
> 4. ACPI is for laptops correct? I'm using a desktop and I've never installed 
> anything ACPI related..

But is ACPI configured in your kernel?

> I'm sorry for a bad bug report It's just that it was my first :) Hope this 
> helps 

Try reading the REPORTING-BUGS file in the main directory of the kernel
source code for more information on useful things to send.

thanks,

greg k-h
