Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSGHSRz>; Mon, 8 Jul 2002 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSGHSRw>; Mon, 8 Jul 2002 14:17:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13064 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317030AbSGHSRS>; Mon, 8 Jul 2002 14:17:18 -0400
Subject: Re: DELL array controller access.
To: Matt_Domsch@Dell.com
Date: Mon, 8 Jul 2002 19:43:25 +0100 (BST)
Cc: dtroth@bellsouth.net, linux-kernel@vger.kernel.org
In-Reply-To: <F44891A593A6DE4B99FDCB7CC537BBBB072469@AUSXMPS308.aus.amer.dell.com> from "Matt_Domsch@Dell.com" at Jul 08, 2002 01:17:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RdTp-0002re-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RedHat 7.0 and it does not see the board.  Where can I get a 
> > EISA buss AHA-154x driver to access the array controller?
> 
> David, Dell never produced a Linux device driver for the Dell SCSI Array
> card.  I had forgotten about the AHA-154x emulation feature, but since it
> doesn't seem to work, it's unlikely that it ever will.  Everyone who worked
> on that project 9 years ago has left for other opportunities.  The on-board
> NCR SCSI controller should still work, and you can use software RAID quite
> easily to accomplish similar functionality.

The EISA bus AHA154x equivalent is the AHA174x which we do support. I don't
know what the Dell arrays used however
