Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288695AbSADRlG>; Fri, 4 Jan 2002 12:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSADRk4>; Fri, 4 Jan 2002 12:40:56 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:37117 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S281450AbSADRks>; Fri, 4 Jan 2002 12:40:48 -0500
Date: Fri, 4 Jan 2002 11:40:47 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil>
To: usenet2001-12@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <E16MXHz-0000gr-00@sites.inka.de>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> In article <200201041402.IAA80257@tomcat.admin.navo.hpc.mil> you wrote:
> > In my experience, SCSI is not cost effective for systems with a single disk.
> > As soon as you go to 4 or more disks, the throughput of SCSI takes over unless
> > you are expanding a pre-existing workstation configuration.
> 
> IDE Scales fine to 8 Channels (aka 8 Drives). Anything more than 8 Drives on
> an HBA is insane anyway.
> 
> I love the FC-to-IDE(8) Solution. You get Hardware Raid with 8 Channels, each
> drive a didicated channel, thats much more reliable than usual 2 or 3 channel
> SCSI Configurations.
> 
> Do you realy run more than say 10 hard disk devices on a single SCSI Bus,
> ever?

Only place I've seen that (not sure it was true SCSI though) was on a
Cray file server - each target (4) was itself a raid 5, with 5 transports.
That would be total of 20 disks. The four targets were striped together in
software to form a single filesystem. I think that was our first over 300GB
filesystem (several years ago). Now we are using 1 TB to 5TB filesystems
with nearly 5 million files each.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
