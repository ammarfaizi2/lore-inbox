Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129876AbRBBU6l>; Fri, 2 Feb 2001 15:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130197AbRBBU6b>; Fri, 2 Feb 2001 15:58:31 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:53010 "EHLO devel.uklinux.net")
	by vger.kernel.org with ESMTP id <S130177AbRBBU6Q>;
	Fri, 2 Feb 2001 15:58:16 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Fri, 2 Feb 2001 20:59:37 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Every Make option ends in error.
Message-ID: <Pine.LNX.4.21.0102022052090.31663-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys, 
 I guess I'm doing something stupid, so please can somebody point it out
and put me out of my misery ?
 
 Copied a plain 2.4.0 tree to a new directory, patched it to 2.4.1 without
any errors. Then I realised it had all the object files from my last
compile, so I thought "make mrproper" was called for. It did a little,
then

rm: include/asm: is a directory
make: *** [mrproper] Error 1

"make clean" and "make oldconfig" stop with similar errors, "make
clean" is in "symlinks" at the time.

This piece of makefile looks to be the same as in 2.4.0, which worked.

I'm running make 3.77.

Any comments, please ?

Ken

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
