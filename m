Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289796AbSAKAQD>; Thu, 10 Jan 2002 19:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289800AbSAKAPy>; Thu, 10 Jan 2002 19:15:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289796AbSAKAPu>; Thu, 10 Jan 2002 19:15:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Date: 10 Jan 2002 16:15:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1larf$afl$1@cesium.transmeta.com>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020110013856.A26151@devcon.net> <20020110024240.GW13931@cpe-24-221-152-185.az.sprintbbd.net> <200201102155.g0ALtkA22362@snark.thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200201102155.g0ALtkA22362@snark.thyrsus.com>
By author:    Rob Landley <landley@trommello.org>
In newsgroup: linux.dev.kernel
> >
> > Er, 'rdev' is an x86-only program, so lets not add common functionality
> > to that.  And I'd rather not throw something onto the end of the
> > 'zImage' since I just got done removing annoying/broken things like
> > that.
> 
> You want it to be an ELF section then?
> 

initrd.  It's already supported on all architectures; initramfs uses
the same buffer-transfer architecture, which means you can use
unmodified bootloaders.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
