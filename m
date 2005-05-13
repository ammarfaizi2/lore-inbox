Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVEMVZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEMVZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEMVZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:25:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38567 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261642AbVEMVZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:25:08 -0400
Subject: Re: Sync option destroys flash!
From: Lee Revell <rlrevell@joe-job.com>
To: mhw@wittsend.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116001207.5239.38.camel@localhost.localdomain>
References: <1116001207.5239.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:25:00 -0400
Message-Id: <1116019500.6380.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 12:20 -0400, Michael H. Warfield wrote:
> 	Under the right circumstances, even copying a single file to a flash
> drive mounted with the "sync" option can destroy the entire drive!
> 
> 	Now that I have your attention!
> 
> 	I found this out the hard way.  (Kissed one brand new $70 USD 1GB flash
> drive good-bye.)  According to the man pages for mount, FAT and VFAT
> file systems ignore the "sync" option.  It lies.

I guess you found out the hard way that the vast majority of Linux docs
are 2-3 years out of date...

> On a real hard
> drive, this will cause "head resonances" as the heads go through
> constant high speed seeks between the cylinder with the FAT tables and
> the data cylinders.  That can't be good, on a continuous basis, for
> drive life.  But it's really a disaster for flash memory.

I have seen a clueless sysadmin destroy several 15,000 RPM SCSI drives
this way by putting the syslog partition and mail spool at opposite ends
of the drive.  I think Alan Cox said something like "these days you can
no longer assume that buggy software won't destroy your hardware".

Lee

