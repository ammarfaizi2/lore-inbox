Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292942AbSCIVTp>; Sat, 9 Mar 2002 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292940AbSCIVTZ>; Sat, 9 Mar 2002 16:19:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12810 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292938AbSCIVTR>; Sat, 9 Mar 2002 16:19:17 -0500
Subject: Re: SCSI Problem 2.4.19-pre2-ac3
To: mblack@csihq.com (Mike Black)
Date: Sat, 9 Mar 2002 21:34:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <000701c1c7af$18333d60$ac542341@cfl.rr.com> from "Mike Black" at Mar 09, 2002 04:12:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16joUE-0002Zu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 11 Seagate 180GB disks in software RAID5 config  (note that "Array Size"
> below looks suspicious -- overflowing?.  also -- why 13 disks when only 12

The largest volume size supported is 2Tb. Not all the tools handle it right
above 1Tb (2^31 sectors).

The scsi errors want reporting to Justin Gibbs as the adaptec driver
maintainer


