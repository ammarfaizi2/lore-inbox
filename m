Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSDXUGZ>; Wed, 24 Apr 2002 16:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312588AbSDXUGY>; Wed, 24 Apr 2002 16:06:24 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:49672 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S312560AbSDXUGX>;
	Wed, 24 Apr 2002 16:06:23 -0400
Date: Wed, 24 Apr 2002 22:06:17 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: initrd bug
Message-ID: <Pine.LNX.4.44.0204242202100.22488-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem on 2.5.7, and now when I'm trying to boot off 2.5.9 
with initrd it is going wrong. Last messages issued are (not exactly)
RAMDISK compressed image found at block 0
Freeing unused initrd memory (96k)
cramfs: bad magic
PANIC cannot mount root
It looks like it's freeing initrd memory before running it. initrd fs is 
cramfs, but using romfs i had exactly the same thing (it was also cramfs: 
bad magic)
WK

