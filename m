Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315446AbSE2TuL>; Wed, 29 May 2002 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSE2TuK>; Wed, 29 May 2002 15:50:10 -0400
Received: from letos.cs.uh.edu ([129.7.240.2]:58577 "EHLO letos.cs.uh.edu")
	by vger.kernel.org with ESMTP id <S315446AbSE2TuJ>;
	Wed, 29 May 2002 15:50:09 -0400
Date: Wed, 29 May 2002 14:50:03 -0500 (CDT)
From: Karthik Thirumalai <karthik@cs.uh.edu>
To: <linux-kernel@vger.kernel.org>
Subject: VM problem in 2.4.x kernels ??
Message-ID: <Pine.GSO.4.33.0205291441030.28563-100000@themis.cs.uh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a program which basically reads udp data (large amounts) from a
socket and writes it to a file. Whenever the network input rate increases
it cause the system to hang or my program is killed due to lack of memory.

I have 256MB RAM + 2 GB swap. Just before my system hangs( or my program
is killed), I have about 1 or 2 MB of physical memory and 1600 MB of swap
free. I don't understand why my program should be killed due to lack of
memory when I have so much of free mem.

I tried this with 2.4.10, 2.4.18 and 2.4.19-pre8-ac5.
I use a 100MB socket queue. (rmem_max)

Could anybody tell me why this happens and a possible fix for this.

Please cc your postings to karthik@cs.uh.edu as I don't subscribe to this
list.

Thanks in advance.

Karthik.

