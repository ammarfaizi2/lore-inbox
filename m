Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHIDg0>; Thu, 8 Aug 2002 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSHIDg0>; Thu, 8 Aug 2002 23:36:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318017AbSHIDgZ>; Thu, 8 Aug 2002 23:36:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: klibc development release
Date: 8 Aug 2002 20:39:52 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aivdi8$r2i$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I'm starting to have enough guts about this to release for
testing...

klibc is a tiny C library subset intended to be integrated into the
kernel source tree and being used for initramfs stuff.  Thus,
initramfs+rootfs can be used to move things that are currently in
kernel space, such as ip autoconfiguration or nfsroot (in fact,
mounting root in general) into user space.

I would particularly appreciate portability comments, since I'm flying
blind on non-i386 machines (anyone want to send me hardware?),
although any bug reports would be appreciated.

    ftp://ftp.kernel.org/pub/linux/libs/klibc/klibc.tar.gz

I haven't bothered putting a version number on it, since it changes
quite often.  I have also published the CVS repository in the
directory above.

	-hpa


P.S. I'm aware gregkh already started a klibc project; I have
discussed it with him and we have agreed my project supercedes his.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
