Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131863AbQLPQ0w>; Sat, 16 Dec 2000 11:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbQLPQ0m>; Sat, 16 Dec 2000 11:26:42 -0500
Received: from gaia.euronet.nl ([194.134.0.10]:13290 "HELO pop1.euronet.nl")
	by vger.kernel.org with SMTP id <S131863AbQLPQ0e>;
	Sat, 16 Dec 2000 11:26:34 -0500
Date: Sat, 16 Dec 2000 16:56:07 +0100 (CET)
From: infernix <infernix@infernix.nl>
To: Niels Kristian Bech Jensen <nkbj@image.dk>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
In-Reply-To: <Pine.LNX.4.30.0012160521580.2805-100000@hafnium.nkbj.dk>
Message-ID: <Pine.LNX.4.21.0012161651390.5677-100000@server.ggmc.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the cause. I read somewhere in a debian bugreport that bootsect.S
can't handle really big (b)vmlinuz images (over 500kb orso). However, I am
wondering why 'make bzdisk' doesn't give me an error or a warning. I mean,
the only purpose of 'make bzdisk' is to build a kernel bootable on a
floppy right?

Regards,

infernix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
