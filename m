Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbRBXUet>; Sat, 24 Feb 2001 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBXUea>; Sat, 24 Feb 2001 15:34:30 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:13834 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129590AbRBXUe0>;
	Sat, 24 Feb 2001 15:34:26 -0500
Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 24 Feb 2001 19:27:02 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Chris Mason <mason@suse.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
In-Reply-To: <20010223231949.D24959@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0102241917020.1720-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(reisertest)

I get the same problems with straight 2.4.2, machine is a k5 with
32Mb. The test results vary depending on what else is on the partition,
but in each case the last file affected is 01017 and there are sequences
of previous_number+4, for up to 8 files (but next file after this might be
previous+7 or previous +15, or sporadic). From other problems I've seen on
the list, maybe I need more memory to run reiserfs ?
 
This happens whether I compile the kernel (and/or the test program) with
Red Hat's revised gcc-2.96 or with egcs. First testing was with a
partition created from the rpm version of mkreiserfs, while running a
2.96-built-kernel. I've now recreated the partition while running a kernel
compiled with egcs ('kgcc'), the only difference is some of the numbers
for the affected files differ.
 
Partition approx 1.7Gb, built with defaults, block size is 4096.
 
More details of config or whatever available if required.
 
Ken

