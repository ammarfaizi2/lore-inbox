Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRJ1IGK>; Sun, 28 Oct 2001 03:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277777AbRJ1IGB>; Sun, 28 Oct 2001 03:06:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277758AbRJ1IFq>; Sun, 28 Oct 2001 03:05:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
Date: 28 Oct 2001 01:06:15 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rge9n$sua$1@cesium.transmeta.com>
In-Reply-To: <20011027012016.F23590@turbolinux.com> <E15xVcA-0003bG-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15xVcA-0003bG-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > but I think you are confusing intent with implementation.  The intent
> > (AFAICS) is to mark the kernel tainted ONLY if a closed-source module
> > is loaded, rather than to be a "license police" mechanism, especially
> > for sources that have been included in the kernel for a long time.
> 
> "BSD" can indicate totally closed source material as well as other stuff
> 

I was thinking about that, and that doesn't seem right to me -- you
can make closed-source derivative works based on BSD but I would
typically not refer to them as "BSD" license (think SunOS 4.1 here...)

> 
> Also Keith is right - if it is GPL compatible BSD code linked with the
> kernel then its correct to describe it as Dual BSD/GPL anyway
> 

I think the idea of making a standard set of macros available is a
good idea for two reasons:

a) It avoids mispellings;

b) It makes it possible to apply standard definitions to the codified
   strings.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
