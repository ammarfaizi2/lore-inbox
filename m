Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUATKcC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 05:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUATKcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 05:32:02 -0500
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:62479 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S265340AbUATKb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 05:31:59 -0500
Message-ID: <200401201130310490.1D90BAC9@192.168.128.16>
In-Reply-To: <400C50FA.5070809@rdslink.ro>
References: <400C50FA.5070809@rdslink.ro>
X-Mailer: Courier 3.50.00.09.1092 (http://www.rosecitysoftware.com) (P)
Date: Tue, 20 Jan 2004 11:30:31 +0100
From: "Carlos Velasco" <lkernel@newipnet.com>
To: "Beratco Matei jr." <mathew@rdslink.ro>, linux-kernel@vger.kernel.org
Subject: Re[2]: iswraid calling modprobe when scsi statically
  compiled?
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2004 at 23:49 Beratco Matei jr. wrote:

>You can move the line with SCSI before the one with
>IDE (the rest does not matter) and recompile.

It worked perfectly. Thanks.

>It worked for me, and i'm booting from 2 Seagate 80Gb
>HDD's in RAID0 (so no modules allowed for SATA/SCSI/RAID).

* Sorry by the off-topic *
However I have problems when booting. I'm using GRUB trying to boot
directly over ICH5R RAID without any success. It doesn't see any known
filesystem in (hd0).
Are you booting directly to RAID disks? I'm using RAID1, it may be a
bit different.
What boot loader are you using?

Regards,
Carlos Velasco


