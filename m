Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129782AbRBVDTi>; Wed, 21 Feb 2001 22:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbRBVDT2>; Wed, 21 Feb 2001 22:19:28 -0500
Received: from rhinocomputing.com ([161.58.241.147]:61456 "EHLO
	rhinocomputing.com") by vger.kernel.org with ESMTP
	id <S129782AbRBVDTW>; Wed, 21 Feb 2001 22:19:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.34104.791600.203558@rhino.thrillseeker.net>
Date: Wed, 21 Feb 2001 22:19:20 -0500
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
In-Reply-To: <peter@cadcamlab.org> Wednesday, 21 February 2001 21:13:30 -0600
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>
	<Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>
	<20010221211330.A21010@cadcamlab.org>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error in a make bzImage:

nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
make: *** [bzImage] Error 2
