Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRDLNdB>; Thu, 12 Apr 2001 09:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135187AbRDLNcl>; Thu, 12 Apr 2001 09:32:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135186AbRDLNcc>; Thu, 12 Apr 2001 09:32:32 -0400
Subject: Re: Digi Xem Problems
To: mbabcock@fibrespeed.net (Michael T. Babcock)
Date: Thu, 12 Apr 2001 14:34:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD5A399.71065F90@fibrespeed.net> from "Michael T. Babcock" at Apr 12, 2001 08:46:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nhEo-0000XP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Digi's engineering staff _may_ look at this problem but since they don't
> officially support kernels not released by RedHat, we have no
> guarantees.  Any ideas out there?

Well if its what I think their driver probably doesnt work with 2.2.16 either.
The API for tty interfaces changed during 2.2 to fix a nasty problem with 
poll tables that couldnt easily be fixed any other way. All the in kernel
drivers were updated but because Digi choose to keep their driver out of their
kernel theirs was not. Im guessing that is why their driver now fails

