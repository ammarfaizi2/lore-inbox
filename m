Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSAITVC>; Wed, 9 Jan 2002 14:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSAITUw>; Wed, 9 Jan 2002 14:20:52 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:62868 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288955AbSAITUf> convert rfc822-to-8bit; Wed, 9 Jan 2002 14:20:35 -0500
Date: Wed, 9 Jan 2002 20:20:14 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kdev_t changes cause NVdriver compile failure?
Message-ID: <20020109192014.GB8760@neon.hh59.org>
In-Reply-To: <20020109191831.GA8760@neon.hh59.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20020109191831.GA8760@neon.hh59.org>
User-Agent: Mutt/1.3.24i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I forgot the error output:

rm -f nv.o os-interface.o os-registry.o  Module-linux nv_compiler.h NVdriver
cc -c -Wall -Wno-unknown-pragmas -Wno-multichar -O2 -D__KERNEL__ -DMODULE
-D_LOOSE_KERNEL_NAMES -D_X86_=1 -Di386=1 -DUNIX -DLINUX -DNV4_HW -DNTRM
-DRM20 -D_GNU_SOURCE -DRM_HEAPMGR -D_LOOSE_KERNEL_NAMES
-DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2313  -I.
-I/lib/modules/2.5.2-pre10/build/include nv.c
nv.c: In function v_kern_open':
nv.c:1148: invalid operands to binary &
nv.c:1152: invalid operands to binary &
nv.c: In function v_kern_close':
nv.c:1259: invalid operands to binary &
make: *** [nv.o] Error 1

It happens both with gcc version 3.0.4 20020108 (prerelease) and
gcc version 2.95.3 20010315 (SuSE).

Thanks,
Axel Siebenwirth
