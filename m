Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSEVOfr>; Wed, 22 May 2002 10:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEVOfq>; Wed, 22 May 2002 10:35:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315374AbSEVOfo>; Wed, 22 May 2002 10:35:44 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
To: ahu@ds9a.nl (bert hubert)
Date: Wed, 22 May 2002 15:55:56 +0100 (BST)
Cc: znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org
In-Reply-To: <20020522140839.GA9903@outpost.ds9a.nl> from "bert hubert" at May 22, 2002 04:08:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXWu-0001vL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > large machines. I haven't had a chance to run my own test cases on the
> > 2.4.18 kernel from Red Hat 7.3 yet, so I can't make any personal
> > contribution to this discussion.
> 
> RedHat has fixed the problem in its kernels. There are fixes out there, but
> Linus is not applying them. I would venture that this is because they would
> fix the problems *for the moment* and take away interest in revamping VM for
> real.

7.3 has some of what is needed but not all. To go past 16Gb you need highmem
mapped page tables which I'm pretty sure did not make it in.

