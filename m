Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDFUYs>; Sat, 6 Apr 2002 15:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312798AbSDFUYr>; Sat, 6 Apr 2002 15:24:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32273 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312790AbSDFUYq>; Sat, 6 Apr 2002 15:24:46 -0500
Subject: Re: [WTF] ->setattr() locking changes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 6 Apr 2002 21:41:08 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        haveblue@us.ibm.com (Dave Hansen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204061020140.24305-100000@home.transmeta.com> from "Linus Torvalds" at Apr 06, 2002 10:23:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16twzk-0002c8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm...  While we are at it, why don't we remove suid/sgid on truncate(2)?
> 
> Are there any standards saying either way? But yes, it sounds logical.

SuS v2 specifically says they may be cleared
