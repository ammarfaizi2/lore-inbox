Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbRBVAsj>; Wed, 21 Feb 2001 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRBVAsV>; Wed, 21 Feb 2001 19:48:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130462AbRBVAsO>; Wed, 21 Feb 2001 19:48:14 -0500
Subject: Re: PROBLEM: ext2 superblock issue on 2.4.1-ac20
To: psubash@turbolinux.com (Prasanna P Subash)
Date: Thu, 22 Feb 2001 00:50:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010221163514.A671@turbolinux.com> from "Prasanna P Subash" at Feb 21, 2001 04:35:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VjyB-000391-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I just oldconfiged linux kernel with my 2.4.1 .config. When I boot the new
> 2.4.1-ac20 kernel, I get a message saying that my ext2 superblock is corrup=
> ted.
> I get a message asking me to run e2fsck -b 8193 <...hdd dev..>
> My 2.4.0-ac4 that I've been running for more than 2-3 weeks now has no prob=
> lems
> booting though.
> 
> 	What am I doing wrong ? I would be glad to give more info.

Sounds like a driver change broke the handling for your disks or re-ordered
them. 

What hardware
