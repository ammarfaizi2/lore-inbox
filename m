Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDCQ4K>; Tue, 3 Apr 2001 12:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRDCQ4B>; Tue, 3 Apr 2001 12:56:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131742AbRDCQzt>; Tue, 3 Apr 2001 12:55:49 -0400
Subject: Re: ReiserFS? How reliable is it? Is this the future?
To: nicholas@petreley.com (Nicholas Petreley)
Date: Tue, 3 Apr 2001 17:57:00 +0100 (BST)
Cc: harri@synopsys.COM (Harald Dunkel), linux-kernel@vger.kernel.org
In-Reply-To: <20010403091955.A379@petreley.com> from "Nicholas Petreley" at Apr 03, 2001 09:19:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kU75-0008Qx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bad (2.2 kernels)
> 
> * Nothing I can think of

Security exploit according to bugtraq, but Im pretty sure it wont take Chris
Mason and friends long to fix that.

> The bad (2.4.x kernels):
> 
> * Some corruption problems with various 2.4.x kernels, but
> people are reporting ext2 problems, too, so this is
> probably due at least in part to IDE/PCI chipset issues

With the latest tail fixes Im fairly sure the remaining corruptions are not
reiserfs specific - but not yet 100% confident.

> * Some corruption problems if an application 
> uses an nfs-mounted reiserfs partition during
> an unexpected shutdown of the nfs server

(You want the NFS patches too)


