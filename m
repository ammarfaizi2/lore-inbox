Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbRGFVCk>; Fri, 6 Jul 2001 17:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbRGFVCa>; Fri, 6 Jul 2001 17:02:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24070 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266846AbRGFVCS>; Fri, 6 Jul 2001 17:02:18 -0400
Subject: Re: BIGMEM kernel question
To: anderson@centtech.com
Date: Fri, 6 Jul 2001 22:02:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B4624C9.18290280@centtech.com> from "Eric Anderson" at Jul 06, 2001 03:51:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IckP-0004w6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel.  My machine has 4GB of RAM, and 6GB of swap.  It appears that I
> can only allocate 2930 MB (using heapc_linux and other programs).  What
> do I need to do to get Linux to allow allocation of all available memory

A non x86 based computer. Its basically impractical to map more than 3Gb of
memory to user space per process on x86. You can use mmap and shared memory
to do DOS EMS like tricks with gig rather than 64K sized chunks but you want
a real 64bit processor to go further

Alan


