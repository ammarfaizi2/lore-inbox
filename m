Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbREIU6e>; Wed, 9 May 2001 16:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREIU6O>; Wed, 9 May 2001 16:58:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132373AbREIU6I>; Wed, 9 May 2001 16:58:08 -0400
Subject: Re: [PATCH] Fixes for Incorrect kmalloc() Sizes
To: david@blue-labs.org (David)
Date: Wed, 9 May 2001 21:57:17 +0100 (BST)
Cc: cat@waulogy.stanford.edu (david chan),
        torvalds@transmeta.com (Linus Torvalds),
        emu10k1-devel@opensource.creative.com,
        eokerson@quicknet.net (Ed Okerson), linux-kernel@vger.kernel.org
In-Reply-To: <3AF9A65F.4050208@blue-labs.org> from "David" at May 09, 2001 01:19:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xb1M-0003GE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel ixj.c and associated files are severely out of date and cause 
> hard machine hangs when used (kernel 2.4.n).  I suggest that the files 
> in the telephony directory be brought up to date with the current CVS 
> code.  At least the CVS code only causes an OOPS and doesn't kill the 
> whole machine.

This is a discussion we had a while back with the ixj maintainers. The 
outcome is that yes I agree, no I've not had patches since a discussion a while
back about dynamic allocation

