Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSFDPZN>; Tue, 4 Jun 2002 11:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSFDPZM>; Tue, 4 Jun 2002 11:25:12 -0400
Received: from [213.225.90.118] ([213.225.90.118]:19465 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S313537AbSFDPZK>;
	Tue, 4 Jun 2002 11:25:10 -0400
Date: Tue, 4 Jun 2002 17:26:46 +0200 (CEST)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@ketil.np
To: linux-kernel@vger.kernel.org
Subject: One disk, one filesystem, no partitions?
Message-ID: <Pine.LNX.4.40L0.0206041716270.1413-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a question regarding something I came across a while ago. A
filesystem (reiserfs) had been set up on a disk without making any
partitions. The entry in /etc/fstab looked something like this:

/dev/hdc	/mount/point	reiserfs	defaults	0 0

When I saw this, I instinctively partitioned the drive so that /dev/hdc1
was mounted instead. But was this really necessary? If I want to put only
one filesystem on a disk, do I need to partition at all? It seemed to work
fine before I changed it. I had just never heard of this before, and
automatically assumed that the problems the box was having could be
related to this.

Ketil

