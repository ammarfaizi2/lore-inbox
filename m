Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317145AbSEXOrr>; Fri, 24 May 2002 10:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317146AbSEXOrq>; Fri, 24 May 2002 10:47:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317145AbSEXOro>; Fri, 24 May 2002 10:47:44 -0400
Subject: Re: Quota patches
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 24 May 2002 16:07:41 +0100 (BST)
Cc: jack@suse.cz (Jan Kara), alan@lxorguk.ukuu.org.uk (Alan Cox),
        nathans@sgi.com (Nathan Scott),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205231002460.1006-100000@home.transmeta.com> from "Linus Torvalds" at May 23, 2002 10:03:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGfN-0006Ub-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This makes me pretty certain we just do not want to have the backwards-
> compatibility layer in 2.5.x
> 
> Are there _any_ reasons to use the old stuff, if the fix is just to
> upgrade to a newer quota tool?

Most people use 2.4 with quota tools and 32bit uid quota already, so its
not much of a breakage at all. The 2.4 quota base code is unusable in the
real world so the problem got settled by the vendor trees
