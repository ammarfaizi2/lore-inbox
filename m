Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274790AbRJAJGR>; Mon, 1 Oct 2001 05:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274791AbRJAJGH>; Mon, 1 Oct 2001 05:06:07 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:52669 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S274790AbRJAJF5>; Mon, 1 Oct 2001 05:05:57 -0400
Date: Mon, 1 Oct 2001 10:06:23 +0100
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
Message-Id: <200110010906.f9196NM32571@irishsea.craig-wood.com>
To: viro@math.psu.edu, Erik Andersen <andersen@codepoet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <Pine.GSO.4.21.0110010345110.14660-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110010345110.14660-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, viro@math.psu.edu wrote:
> 	Actually, you've found a rather nasty bug in acorn.c - code in
> the current tree fails if it tries to look for acorn-style partition
> table on a large-sector disk.

Just for the record - I don't think Acorn disks can have sectors
bigger than 1k.  (I never managed to get the 640Mb MO discs working, I
had to get the 512 byte sectored 512 Mb ones instead.)  I just checked
in the PRM and it agrees with my very rusty memory.

I have some acorn partitioned MO discs lying around if you want to see
the first few sectors off the disc...

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
