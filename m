Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264121AbRFDGro>; Mon, 4 Jun 2001 02:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264122AbRFDGre>; Mon, 4 Jun 2001 02:47:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264121AbRFDGrb>; Mon, 4 Jun 2001 02:47:31 -0400
Subject: Re: [PATCH] fs/devfs/base.c
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 4 Jun 2001 07:44:50 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), aki.jain@stanford.edu (Akash Jain),
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        su.class.cs99q@nntp.stanford.edu
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 03, 2001 04:55:00 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156o6c-0005AB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
>    noticeable portion of it. It doesn't matter if you "know" your caller

Umm Linus on what platform - its 8K or more on all that I can think of

> Ergo: the simple rule of "don't allocate big structures of the stack" is
> always a good rule, and making excuses for it is bad.

We have a very large number of violators of 1K of stack, and very few of 2K 
right now.

