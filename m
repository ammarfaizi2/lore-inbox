Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSETMHg>; Mon, 20 May 2002 08:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSETMHf>; Mon, 20 May 2002 08:07:35 -0400
Received: from sylfest.hiof.no ([158.36.16.13]:51656 "EHLO sylfest.hiof.no")
	by vger.kernel.org with ESMTP id <S315923AbSETMHe>;
	Mon, 20 May 2002 08:07:34 -0400
Date: Mon, 20 May 2002 14:07:34 +0200 (CEST)
From: Jens Christian Skibakk <jenscski@sylfest.hiof.no>
To: linux-kernel@vger.kernel.org
cc: jens.c.skibakk@hiof.no
Subject: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
Message-ID: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I unpack a tar-archive containing many files (about halv a million)
this errors occures in the dmesg output:
EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28

and the program complins about: No space left on device, but df -h shows
that there is over 1G free on the hd.

After this error occurs the hd contains errors and need to be checked.

The filesystem on the hd is ext3.

I have tested this with to kernel-verions, on both 2.4.18 and
2.4.19-pre8-ac3 the error occurs.


Else my system is :
glibc: 2.2.5
binutils: 2.12.90.0.1
gcc: 2.95.4


Jens-Christian Skibakk

