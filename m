Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132222AbRAPRBA>; Tue, 16 Jan 2001 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRAPRAk>; Tue, 16 Jan 2001 12:00:40 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:24081 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S131652AbRAPRAf>; Tue, 16 Jan 2001 12:00:35 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95194@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Eddie Williams'" <Eddie.Williams@steeleye.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>,
        linux-kernel@vger.kernel.org,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order? 
Date: Tue, 16 Jan 2001 11:56:13 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is this a SCSI ML problem?  The problem is that the OS can't figure
> out 
> where to mount root from.  Sounds like an OS problem.
> I think the file system label is the leading candidate to solve this.  One
> 
> really does not care if the root disk is called /dev/sda or /dev/fred.
> All 
> one cares is that you can boot your system and the right disks are
> mounted.  
> What I have seen so far with the fs label this either does solve this
> today or 
> it can solve this.  I notice today on some systems the entries in
> /etc/fstab 
> already are "deviceless" in that it does not have the disk/partition but 
> simply the disk label.
> 
> Can lilo use a label for the root disk also?  I have not looked into that
> yet. 
>  If it does not can it?  When I noticed the use of the label in /etc/fstab
> my 
> first thought was "alright, someone is solving this problem."  I have not 
> taken the time - not a burning issue with me right now - to see if this is
> all 
> done yet though.
> 
> Keep in mind that the example where /dev/sda is where root lies is that
> "easy" 
> case.  The hard case is what happens if someone installs on /dev/sdg.  Now
> 
> they boot up with a disk array turned off.  Is the mid-layer going to
> figure 
> out that what is now /dev/sda suppose to be /dev/sdg?  Or they install to 
> /dev/sdb and /dev/sda goes bad so they pull it out?
	[Venkatesh Ramamurthy]   If we can truly go for label based mouting
and lilo'ing this would solve the problem. Anybody doing this?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
