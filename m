Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSKPC3Y>; Fri, 15 Nov 2002 21:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbSKPC3Y>; Fri, 15 Nov 2002 21:29:24 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53168 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267206AbSKPC3X>; Fri, 15 Nov 2002 21:29:23 -0500
Subject: Re: 2.4.47 bug - PnPBIOS GPFs and kernel panics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trelane@digitasaru.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115173703.GA2828@digitasaru.net>
References: <20021115173703.GA2828@digitasaru.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 03:02:53 +0000
Message-Id: <1037415773.21922.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 17:37, Joseph Pingenot wrote:
> Hello.
> 
> Upon enabling PnPBIOS in the kernel, compiling, and rebooting into it,
>   I get greeted with the following:
> PnPBIOS: Found PnPBIOS installation structure at 0xc00f7d50
> PnPBIOS: PnPBIOS version 1.0 entry 0xf0000:0xaa05, dseg 0x400
> pnp: 00:03: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:03: ioport range 0x40b-0x40b has been reserved
> pnp: 00:03: ioport range 0x480-0x48f has been reserved
> pnp: 00:03: ioport range 0x4db-0x4db has been reserved
> pnp: 00:03: ioport range 0x1000-0x105f has been reserved
> general protection fault: 0040

Congratulations your PnP BIOS appears to be buggy. Can you send me the
output of dmidecode, also let me know if you used acpi 

