Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292450AbSBPRA5>; Sat, 16 Feb 2002 12:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292449AbSBPRAs>; Sat, 16 Feb 2002 12:00:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292447AbSBPRAd>; Sat, 16 Feb 2002 12:00:33 -0500
Subject: Re: kernel 2.2.14 + AMI RAID
To: pmartinez@heraldo.es (Paco Martinez)
Date: Sat, 16 Feb 2002 17:14:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01d101c1b6e5$3e9c20f0$ef01a8c0@PCZ014> from "Paco Martinez" at Feb 16, 2002 01:27:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c8Q2-0006gn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My PC has Red Hat 6.2 + kernel 2.2.14 + AMI MegaRAID LD0 RAID5 + 5 Hard Disk
> Ultra SCSI..
> 
> That kernel is giving me many problems -about virtual memory and mysql-.
> Therefore, I would like to install another newer kernel, but I'm afraid AMI
> MegaRAID could give problems after upgrading..

I've not seen any "new" problems with the megaraid appear in newer drivers
except for a now squashed problem with 64bit support and HP firmware that
was killed pretty rapidly.

The current firmware seems to have precisely the same problems in 2.4 as
in 2.2 and nothing worse. (That is if you have spare CPU you'll probably
double your performance by throwing it in the bin and using software raid5
and a generic aic7xxx scsi controller)
