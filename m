Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284610AbRLRSn0>; Tue, 18 Dec 2001 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLRSls>; Tue, 18 Dec 2001 13:41:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10515 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284557AbRLRSlC>; Tue, 18 Dec 2001 13:41:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to use >3G memory per process
Date: 18 Dec 2001 10:40:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vo2jk$i8i$1@cesium.transmeta.com>
In-Reply-To: <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com>
By author:    "Wenyong Deng" <wydeng@platodesign.com>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> I read about 3.5G-per_process (or 3.5G/0.5G user/kernel space) in this
> mailing list, but I don't find the details of how to do it. I have installed
> Redhat7.2 (kernel 2.4.10enterprise) on a dual CPU 4G memory PC. I wrote a
> simple program to use malloc to allocate memory, and it can never exceeds
> 3G. libhoard didn't help either. My question is:
> 
> [1] What need to be done for the kernel to support 3.5G or more user address
> space per process?
> 
> [2] What need to be done at compilation time? Any option for
> compiler/linker?
> 

You need a patch from Andrea; you also need to either run kernel boot
protocol 2.03 (a patch from me, plus a compatible bootloader), *OR*
run without initrd.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
