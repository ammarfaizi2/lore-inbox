Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289589AbSAKGxp>; Fri, 11 Jan 2002 01:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289743AbSAKGxg>; Fri, 11 Jan 2002 01:53:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289589AbSAKGxV>; Fri, 11 Jan 2002 01:53:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc requirements, round 2
Date: 10 Jan 2002 22:53:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1m24q$qrd$1@cesium.transmeta.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB2C@mail0.myrio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <D52B19A7284D32459CF20D579C4B0C0211CB2C@mail0.myrio.com>
By author:    "Torrey Hoffman" <torrey.hoffman@myrio.com>
In newsgroup: linux.dev.kernel
> 
> My concern is with the minority who are using initrd, and in
> some cases a very customized initrd.  
> 

They can presumably use whatever they already do, except they'll make
it into a .cpio.gz file instead of an .img.gz file.

> The important thing, I think, is that it should be easy for
> less-than-guru level hackers to add programs to the initramfs,
> even if the program they want can't be linked with klibc.
> 
> This really comes down to: What will the build process be for
> these initramfs images?
> 
> By the way, is initramfs intended to supercede initrd, or will 
> they co-exist?  

Eventually supercede; it will let us pull out an amazing amount of
crud.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
