Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSANSyP>; Mon, 14 Jan 2002 13:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSANSx3>; Mon, 14 Jan 2002 13:53:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288834AbSANSxB>; Mon, 14 Jan 2002 13:53:01 -0500
Subject: Re: Hardwired drivers are going away?
To: david.lang@digitalinsight.com (David Lang)
Date: Mon, 14 Jan 2002 19:04:34 +0000 (GMT)
Cc: esr@thyrsus.com (Eric S. Raymond), alan@lxorguk.ukuu.org.uk (Alan Cox),
        babydr@baby-dragons.com (Mr. James W. Laferriere),
        cate@debian.org (Giacomo Catenazzi),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.40.0201141045130.22904-100000@dlang.diginsite.com> from "David Lang" at Jan 14, 2002 10:50:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCPK-0002Yt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. security, if you don't need any modules you can disable modules entirly
> and then it's impossible to add a module without patching the kernel first
> (the module load system calls aren't there)

Urban legend.

> 2. speed, there was a discussion a few weeks ago pointing out that there
> is some overhead for useing modules (far calls need to be used just in
> case becouse the system can't know where the module will be located IIRC)

I defy you to measure it on x86

> 3. simplicity in building kernels for other machines. with a monolithic
> kernel you have one file to move (and a bootloader to run) with modules
> you have to move quite a few more files.

tar or nfs mount; make modules_install.
