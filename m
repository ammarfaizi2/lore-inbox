Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSGMNKq>; Sat, 13 Jul 2002 09:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGMNKp>; Sat, 13 Jul 2002 09:10:45 -0400
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:7953 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S312560AbSGMNKm>; Sat, 13 Jul 2002 09:10:42 -0400
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBB0724D2@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: greg@kroah.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
cc: jgarzik@mandrakesoft.com
Subject: RE: Removal of pci_find_* in 2.5
Date: Sat, 13 Jul 2002 08:13:24 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 112EF8F22241944-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ordering, is simply hard-coding something that should really be in 
> > userspace.  Depending on pci_find_device logic / link order to 
> > still-boot-the-system after adding new hardware sounds like an 
> > incredibly fragile hope, not a reliable system users can trust.

Yes, but unfortunately it's all we've had for a long time.

> Yes, it still involves some handwaving at this moment in time, but it
> will happen, and I do know about this requirement :)

Then this will solve my #2 factory install problem.   I look forward to this
restriction being removed properly. :-)
(In case you're curious, #1 is customers can't specify the partition
strategy they want at order time, so they wind up blowing away the FI
anyhow).

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

