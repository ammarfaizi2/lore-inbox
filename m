Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276334AbRI1V7O>; Fri, 28 Sep 2001 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276331AbRI1V7G>; Fri, 28 Sep 2001 17:59:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41739 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276333AbRI1V6v>; Fri, 28 Sep 2001 17:58:51 -0400
Subject: Re: all files are executable in vfat
To: Florian.Weimer@RUS.Uni-Stuttgart.DE (Florian Weimer)
Date: Fri, 28 Sep 2001 23:04:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tgbsjvrnm2.fsf@mercury.rus.uni-stuttgart.de> from "Florian Weimer" at Sep 28, 2001 11:50:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n5ju-0008Uz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not for filesystems that store permission info, e.g., ext2,
> > ISO9660+RockRidge, etc.
> 
> Sometimes I wish there was a uid/gid option for ext2, too.  (Doing
> forensic analysis as root is a bit risky. ;-)

Usermode Linux can mount your ext2fs block device in the virtual linux,
and with copy on write of changes to a different file.

Alan
