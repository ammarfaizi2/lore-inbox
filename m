Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264888AbUDWR5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbUDWR5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUDWR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:57:06 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:36568 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264888AbUDWR5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:57:01 -0400
Subject: Re: Unable to read UDF fs on a DVD
From: Pat LaVarre <p.lavarre@ieee.org>
To: kronos@kronoz.cjb.net
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040423162801.GA5396@dreamland.darkstar.lan>
References: <20040423162801.GA5396@dreamland.darkstar.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1082743002.3099.23.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2004 11:56:42 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2004 17:57:00.0026 (UTC) FILETIME=[602935A0:01
	C4295C]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:3.55468 C:49 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> DVD+RW ... UDF ... can mount (kernel 2.6.5) w/o problems:
> ...# mount -t udf -oro /dev/hdc /cdrom
> dmesg:
> udf: registering filesystem
> ...
> UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'CDROM', timestamp 2004/04/20 10:06 (1078)
> ...

So far so good.

> But ... unable to stat/read/whatever the files:
> 
> ....# ls /cdrom
> /bin/ls: /cdrom/Bakuretsu Tenshi - 01.avi: No such file or directory
> /bin/ls: /cdrom/Bakuretsu Tenshi - 02.avi: No such file or directory
> [etc]
> 
> I can mount the disk and read it using ISO9660 instead of UDF (filenames
> are 8+3, no Joliet it seems), and I can read it under WinXP. It
> shouldn't be damaged.

Q1) Any Linux dmesg as you try to read or umount?

Q2) What text does the DIR /S command of Windows produce?

> created under Windows, using Easy CD Creator
> (don't know the details).

Q3) What does Linux fsck tell you, before you mount -o ro (or after you
umount)?

Pat LaVarre

P.S. The subscriber-only archives of linux_udf@h... currently show
Linux-2.6.5 issues now under discussion, including an issue people have
reproduced by downloading a huge trial .exe into Windows and then
copying a file of more than 2 GiB to the disc.

-----Forwarded Message-----
From: Pat LaVarre
Cc: linux_udf@h...
Subject: Re: Bug with UDF file system
Date: 20 Apr 2004 10:34:47 -0600
...

My own most recent blog re the mystery of install & run of the phg fsck
in Linux from virus-free source is:

phg fsck of UDF for Linux
http://udfko.blog-city.com/read/577369.htm
...


