Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSEIOhQ>; Thu, 9 May 2002 10:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSEIOhO>; Thu, 9 May 2002 10:37:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27402 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313183AbSEIOhN>; Thu, 9 May 2002 10:37:13 -0400
Subject: Re: Anyone aware of known issues with the scsi driver in kernel-smp-2
To: MMARTINEZ@intranet.reeusda.gov (Martinez, Michael - CSREES/ISTM)
Date: Thu, 9 May 2002 15:56:18 +0100 (BST)
Cc: linux-scsi@vger.kernel.org ('linux-scsi@vger.kernel.org'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <630DA58AD01AD311B13A00C00D00E9BC05D20130@CSREESSERVER> from "Martinez, Michael - CSREES/ISTM" at May 09, 2002 09:20:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175pL8-0003sx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any sort of write and recover procedure (tar; dump; cat; dd) results in
> random byte mistakes in the recovered data. These byte mistakes always
> follow the form of being offset from the original byte, by 2.

Make sure scsi parity is enabled on the device. Make sure the cabling is
within specification and the termination good.

Alan
