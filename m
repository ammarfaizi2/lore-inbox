Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSADQeG>; Fri, 4 Jan 2002 11:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSADQdy>; Fri, 4 Jan 2002 11:33:54 -0500
Received: from quechua.inka.de ([212.227.14.2]:10574 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S287449AbSADQdu>;
	Fri, 4 Jan 2002 11:33:50 -0500
From: Bernd Eckenfels <usenet2001-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <200201041402.IAA80257@tomcat.admin.navo.hpc.mil>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16MXHz-0000gr-00@sites.inka.de>
Date: Fri, 4 Jan 2002 17:33:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201041402.IAA80257@tomcat.admin.navo.hpc.mil> you wrote:
> In my experience, SCSI is not cost effective for systems with a single disk.
> As soon as you go to 4 or more disks, the throughput of SCSI takes over unless
> you are expanding a pre-existing workstation configuration.

IDE Scales fine to 8 Channels (aka 8 Drives). Anything more than 8 Drives on
an HBA is insane anyway.

I love the FC-to-IDE(8) Solution. You get Hardware Raid with 8 Channels, each
drive a didicated channel, thats much more reliable than usual 2 or 3 channel
SCSI Configurations.

Do you realy run more than say 10 hard disk devices on a single SCSI Bus,
ever?

Greetings
Bernd
