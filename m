Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTBEWsN>; Wed, 5 Feb 2003 17:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbTBEWsN>; Wed, 5 Feb 2003 17:48:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5906 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265097AbTBEWsM>; Wed, 5 Feb 2003 17:48:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc update
Date: 5 Feb 2003 14:57:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1s4t1$ck9$1@cesium.transmeta.com>
References: <20030205052354.GL15544@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030205052354.GL15544@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
>
> For those wondering what's happening with klibc, here's an update...
> 
> I have it building relatively well within the kernel, and have modified
> the usr/gen_init_cpio.c file to add files to the cpio "blob".  That all
> seems to work, but I don't seem to be able to extract the files properly
> (or at least that's what I'm guessing is happening).
> 
> If anyone wants to see the current progress, there's a big patch against
> 2.5.59 at:
> 	kernel.org/pub/linux/kernel/people/gregkh/klibc/klibc-2.5.59.patch.gz
> and a bk tree with the different changes broken down into "logical"
> chunks at:
> 	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5
> 
> Any help with trying to debug init/initramfs.c to figure out what is
> going wrong would be greatly appreciated.
> 

Very cool :)

I will look at your stuff some time next week when I'm in .se for
NordU2003.  Until then I'm afraid I'll have my hands full with
non-Linux work :(

	-hpa


P.S. klibc-0.76 removes the much-complained-about Digest::MD5
dependence.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
