Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289382AbSAJKwu>; Thu, 10 Jan 2002 05:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289386AbSAJKwk>; Thu, 10 Jan 2002 05:52:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15880 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289382AbSAJKwZ>; Thu, 10 Jan 2002 05:52:25 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: brownfld@irridia.com (Ken Brownfield)
Date: Thu, 10 Jan 2002 11:04:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020110035944.E25474@asooo.flowerfire.com> from "Ken Brownfield" at Jan 10, 2002 03:59:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Od05-00043k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's true, but at some point in the future I think the work involved
> in making sure all new additional kernel code and all new intra-kernel
> interactions are "tuned" becomes larger than going preemptive all the
> way down.

It makes no difference to the kernel the work is the same in all cases
because you cannot pre-empt while holding a lock. Therefore you have to do
all the lock analysis anyway
