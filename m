Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130835AbRCFB67>; Mon, 5 Mar 2001 20:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbRCFB6t>; Mon, 5 Mar 2001 20:58:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130835AbRCFB6p>; Mon, 5 Mar 2001 20:58:45 -0500
Subject: Re: continous hard disk trashing and error messages - 2.4.2-ac5
To: amitc@brocade.com (Amit Chaudhary)
Date: Tue, 6 Mar 2001 02:01:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <FFD40DB4943CD411876500508BAD027901DE2C12@sj5-ex2.brocade.com> from "Amit Chaudhary" at Mar 05, 2001 02:09:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6nO-0008Fo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the kernel 2.4.2 with the patch 2.4.2-ac5 patch, I have been getting continous hard disk trashing and the following errors in the /var/log/messages. I increased the console log level to avoid the messages. Please see below a sample set
> Mar  5 12:15:59 amitc-linux mount: mount: can't open /etc/mtab for writing: Input/output error

Well for once in a while I dont think this is going to be the kernel

> Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=25133118, sector=3670215

uncorrectable error is a bad block on the disk. At least unless something very
odd is happening
