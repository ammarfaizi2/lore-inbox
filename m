Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSGILSt>; Tue, 9 Jul 2002 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSGILSt>; Tue, 9 Jul 2002 07:18:49 -0400
Received: from 62-190-200-33.pdu.pipex.net ([62.190.200.33]:13830 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S314284AbSGILSs>; Tue, 9 Jul 2002 07:18:48 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207091126.MAA01269@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
To: B.Zolnierkiewicz@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz)
Date: Tue, 9 Jul 2002 12:26:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0207091218350.6859-100000@mion.elka.pw.edu.pl> from "Bartlomiej Zolnierkiewicz" at Jul 09, 2002 12:22:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Dont punish performance and do not connect drives on the same channel
> if you can, the same goes for cd and cdrw (if cd -> cdrw of course)...

I don't think he's got much choice with all those devices :-)

> Also there was some problem recently with running 2 ATAPI devices on the
> same channel.

I generally prefer to use EIDE for hard disks, and SCSI for other peripherals, (and disks which are for, e.g. databases, but certainly not for boot disks, or general usage disks).

I tend to find 'silly' problems occuring with ATAPI devices, such as a motherboard/ATAPI CD-ROM drive combination that would never boot from the CD, because the BIOS reset the bus just before booting, and the CD-ROM would respond 'not ready'.  Generally SCSI peripherals tend to have a bit more thought put in to their design.

John.
