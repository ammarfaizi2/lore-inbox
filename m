Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRDNO2W>; Sat, 14 Apr 2001 10:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDNO2L>; Sat, 14 Apr 2001 10:28:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132372AbRDNO2H>; Sat, 14 Apr 2001 10:28:07 -0400
Subject: Re: MO-Drive under 2.4.3
To: kobras@tat.physik.uni-tuebingen.de (Daniel Kobras)
Date: Sat, 14 Apr 2001 15:29:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010414150028.A456@pelks01.extern.uni-tuebingen.de> from "Daniel Kobras" at Apr 14, 2001 03:00:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oR3c-00051v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any of
> > the scsi maintainers seem to care about it right now.
> 
> Err..., now I'm confused. Last time this issue popped up, it was my
> understanding that it's generic_file_{read,write}'s limitation to filesystems
> with logical_blksize >= hw_blksize that makes MOs fail with VFAT. Now, is
> this all moot, or is the SCSI thing just an additional problem?

generic_file_* doesnt handle metadata issues - its too high up

