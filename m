Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbRELXge>; Sat, 12 May 2001 19:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbRELXgY>; Sat, 12 May 2001 19:36:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261346AbRELXgQ>; Sat, 12 May 2001 19:36:16 -0400
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 13 May 2001 00:32:20 +0100 (BST)
Cc: szabi@inf.elte.hu (BERECZ Szabolcs), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105121921550.11973-100000@weyl.math.psu.edu> from "Alexander Viro" at May 12, 2001 07:23:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yis0-0004c9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > root@kama3:/home/szabi# cat /proc/mounts
> > /dev/hdb2 /usr ext2 rw 0 0
> > root@kama3:/home/szabi# swapon /dev/hdb2
> 
> - Doctor, it hurts when I do it!
> - Don't do it, then.
> 
> Just what behaviour had you expected?

EBUSY would be somewhat nicer.
