Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266585AbSKLOPP>; Tue, 12 Nov 2002 09:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSKLOPP>; Tue, 12 Nov 2002 09:15:15 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16806 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266585AbSKLOPO>; Tue, 12 Nov 2002 09:15:14 -0500
Subject: Re: Kernel Memory Errors (Debian Woody 2.4.18-bf2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Lloyd <lloy0076@adam.com.au>
Cc: Neale Banks <neale@lowendale.com.au>, dlloyd@microbits.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112213650.35ce0613.lloy0076@adam.com.au>
References: <20021112094813.602c2dbb.dlloyd@microbits.com.au>
	<Pine.LNX.4.05.10211122130210.2446-100000@marina.lowendale.com.au> 
	<20021112213650.35ce0613.lloy0076@adam.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:46:45 +0000
Message-Id: <1037112405.8500.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 11:06, David Lloyd wrote:
> 
> Neale,
> 
> > Probably an X issue that's not relevant here.
> > 
> > What's the video card?
> 
> It's an i810 Intel Card on an all-in-one mainly SiS based board...not
> there until tomorrow when I can get more details about it.

If it is an i810 using the onboard video make sure you are using XFree86
4.1/4.2 and the -fixed- (using pci_alloc_*) kernel module for it.
Otherwise you may well get weird happenings

Marcelo's current tree has the kernel stuff, supporting XFree 4.1/4.2,
but 4.2 is IMHO a lot better on i810 especially at 3D.


