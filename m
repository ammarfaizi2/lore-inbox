Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315588AbSEVPF1>; Wed, 22 May 2002 11:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315591AbSEVPF0>; Wed, 22 May 2002 11:05:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10770 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315588AbSEVPF0>; Wed, 22 May 2002 11:05:26 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: viro@math.psu.edu (Alexander Viro)
Date: Wed, 22 May 2002 16:24:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        davem@redhat.com (David S. Miller), paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0205221053330.2737-100000@weyl.math.psu.edu> from "Alexander Viro" at May 22, 2002 10:54:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXyr-00020p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 22 May 2002, Alan Cox wrote:
> 
> > > The Xfree86 people are actually sane and hold up the BSD tradition.
> > > They don't even use /proc/bus and killed early /proc/agpgart usage!
> > > Quite the reverse is true.
> > 
> > XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
> > and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
> 
> ... and while we are at flamewar-mongering, none of these files have any
> business being in procfs.

That depends on how you define procfs. Linux is not Plan 9. A lot of it 
certainly is going to cleaner with a devicefs and sysctlfs

