Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbREPJvO>; Wed, 16 May 2001 05:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbREPJvE>; Wed, 16 May 2001 05:51:04 -0400
Received: from [193.193.172.61] ([193.193.172.61]:45834 "EHLO
	mail8.GRUPPOCREDIT.IT") by vger.kernel.org with ESMTP
	id <S261851AbREPJvA>; Wed, 16 May 2001 05:51:00 -0400
Message-ID: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
From: "Chemolli Francesco (USI)" <ChemolliF@GruppoCredit.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 11:56:28 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The argument that "if you use numbering based on where in the 
> SCSI chain
> the disk is, disks don't pop in and out" is absolute crap. 
> It's not true
> even for SCSI any more (there are devices that will aquire 
> their location
> dynamically), and it has never been true anywhere else. Give it up.

We could do something like baptizing disks.. Fix some location
(i.e. the absolutely last sector of the disk or the partition table or
whatever) and store there some 32-bit ID 
(could be a random number, a progressive number, whatever).

At that point it would not matter where the disk is anymore.
Just like with ext2's disklabels used as partition indicators in fstab.
Of course this does raise some problems (what happens if I move the
disk for another computer? Should IDs be random? And if so, how is
numbering done? What should we do if there are duplicate IDs?).

This is a solution as good (or as bad) as any.


Don't shoot at the piano player.

-- 
	/kinkie
