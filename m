Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310703AbSCMQIF>; Wed, 13 Mar 2002 11:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310718AbSCMQHz>; Wed, 13 Mar 2002 11:07:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5651 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310711AbSCMQHq>; Wed, 13 Mar 2002 11:07:46 -0500
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
To: adam@yggdrasil.com (Adam J. Richter)
Date: Wed, 13 Mar 2002 16:22:56 +0000 (GMT)
Cc: davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200203131551.HAA09551@adam.yggdrasil.com> from "Adam J. Richter" at Mar 13, 2002 07:51:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lBWi-0006kZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Diffing the 2.4.18 and 2.5.6 versions of NCR53C8x.c and
> fdomain.c, they look the same, aside from some io_request_lock's
> replaced by scsi_host->host_lock.  dtc.c appears to have a few
> minor changes, which I assume are for 2.5.  So, it looks like
> the NCR53C80 drivers in 2.5.7-pre1 are approximately the correct
> starting point for generating working NCR53C80 drivers in 2.5 (as
> opposed to recopying them from 2.4).  Please correct me if I am wrong.

I don't know what has been merged beyond Dave Jones tree. DaveJ should be
able to tell you. A general give away that you have the right one is that
they are formatted to the linux CodingStyle document.

Alan
