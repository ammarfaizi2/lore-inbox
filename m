Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJZCns>; Fri, 25 Oct 2002 22:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSJZCns>; Fri, 25 Oct 2002 22:43:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36318 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261834AbSJZCns>; Fri, 25 Oct 2002 22:43:48 -0400
Date: Sat, 26 Oct 2002 04:50:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: John Levon <levon@movementarian.org>, Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minimum modutils version
In-Reply-To: <20020930202619.GA31858@compsoc.man.ac.uk>
Message-ID: <Pine.NEB.4.44.0210260447071.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, John Levon wrote:

> Documentation/Changes claims modutils 2.4.2 is still acceptable. However
> it seems at least 2.4.10 is needed for EXPORT_SYMBOL_GPL. What should
> Changes be changed to ?

Sounds reasonable.

Keith:
What's your opinion on the following patch for 2.4 (and a similar one for
2.5)?


--- linux-2.4.19/Documentation/Changes.old	2002-10-26 04:44:26.000000000 +0200
+++ linux-2.4.19/Documentation/Changes	2002-10-26 04:45:06.000000000 +0200
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  modutils               2.4.2                   # insmod -V
+o  modutils               2.4.10                  # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.12                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs

> regards
> john

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



