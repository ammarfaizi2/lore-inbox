Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRDMNHI>; Fri, 13 Apr 2001 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDMNGy>; Fri, 13 Apr 2001 09:06:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63755 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130820AbRDMNGe>; Fri, 13 Apr 2001 09:06:34 -0400
Subject: Re: MO-Drive under 2.4.3
To: detlev@offenbach.fs.uunet.de (Detlev Offenbach)
Date: Fri, 13 Apr 2001 14:08:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041310475000.02120@majestix> from "Detlev Offenbach" at Apr 13, 2001 10:47:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o3Jb-0002q9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem using my MO-Drive under kernel 2.4.3. I have several disks 
> formated with a VFAT filesystem. Under kernel 2.2.19 everything works fine. 
> Under kernel 2.4.3 I cannot write anything to the disk without hanging the 
> complete system so that I have to use the reset button. For disks with an 
> ext2 filesystem it works okay.

This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any of
the scsi maintainers seem to care about it right now.



