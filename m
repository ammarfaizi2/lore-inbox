Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbRE2Q7L>; Tue, 29 May 2001 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261252AbRE2Q7B>; Tue, 29 May 2001 12:59:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37899 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261400AbRE2Q6y>; Tue, 29 May 2001 12:58:54 -0400
Subject: Re: Problem with minor devices numbers in 2.4.4/68k
To: baumann@optivus.com
Date: Tue, 29 May 2001 17:56:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000201c0e853$a4f4a540$bbc8c58f@mycroftpc.llumc.edu> from "Michael Baumann" at May 29, 2001 08:25:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154mnC-0004dI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MINOR(inode->i_rdev) to decode that information. Now under
> 2.4.4, this *appears* to be broken - though I am certain it

Nope . Its right

> But MINOR(inode->i_rdev) always returns 0, no matter which
> minor devices I open.
> If this doesn't belong here, please direct mail me, as this
> has my stymied.

The code looks right, check your config matches between the kernel and your
modules, _especially_ if you are not using modversions
