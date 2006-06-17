Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWFQFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWFQFTN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWFQFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:19:13 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:26372 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750848AbWFQFTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:19:13 -0400
Date: Sat, 17 Jun 2006 13:18:05 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
In-Reply-To: <20060617044625.GA8328@redhat.com>
Message-ID: <Pine.LNX.4.64.0606171315220.2812@raven.themaw.net>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
 <20060617034633.GC2893@redhat.com> <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
 <20060617044625.GA8328@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006, Dave Jones wrote:

> On Sat, Jun 17, 2006 at 12:02:30PM +0800, Ian Kent wrote:
> 
>  > >  > I've been having trouble with my Radeon card not working with X.
>  > >  > 
>  > >  > 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
>  > >  > 9550]
>  > >  > 
>  > >  > The only thing I can find that may be a clue is:
>  > >  > 
>  > >  > Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
>  > >  > Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
>  > >  > translation table.
>  > >  > Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
>  > >  > Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
>  > >  > with error -12
>  > >  
>  > > Is this with the free Xorg drivers, or the ATI fglx thing ?
>  > > I don't think I've ever seen agp_generic_create_gatt_table() fail before,
>  > > and that hasn't changed for a looong time.
>  > 
>  > xorg driver yep.
> 
> Bizarre, I have no ideas.
> 
> full dmesg ? lspci ?
> This is running 64 bit mode or 32 ?

I'll boot without X to get this and yes x86_64.

I believe that I will be able to get Rawhide guests to boot and 
install once I can get this working. I can then turf my Vmware.

Ian

