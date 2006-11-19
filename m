Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbWKSSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWKSSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWKSSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:25:57 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:52122 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932769AbWKSSZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:25:56 -0500
Date: Sun, 19 Nov 2006 19:25:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Schmidt <lkml@digadd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to format a disk in an USB-Floppy-drive
In-Reply-To: <456081CE.9090205@digadd.de>
Message-ID: <Pine.LNX.4.61.0611191925220.24349@yvahk01.tjqt.qr>
References: <456081CE.9090205@digadd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How do I actually low-level format a floppy disk in an USB-Floppy-Disk-Drive?
>
> I tried as with usual drives, using fdformat:
>
> [~]>fdformat /dev/sdd
> Could not determine current format type: Invalid argument
>
> But setting the format failed as well:
> [~]>setfdprm -p /dev/sdd 1440/1440
> ioctl: Invalid argument
>
> Next up scsifmt:
>
> [~]>./scsifmt /dev/sdd fmt
> scsifmt: non-sense ioctl error
>
> Didn't work too well, too. Any ideas?


Does not mkfs suffice?


	-`J'
-- 
