Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWBML6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWBML6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWBML6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:58:55 -0500
Received: from lucidpixels.com ([66.45.37.187]:23959 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932091AbWBML6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:58:55 -0500
Date: Mon, 13 Feb 2006 06:58:53 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Is my SATA/400GB drive dying?
Message-ID: <Pine.LNX.4.64.0602130658110.21652@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I turned off smartd and when I cat /dev/zero > /mnt/disk/file, I get the 
following errors:

[37978.030178] ata6: no sense translation for status: 0x51
[37978.030185] ata6: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
0x3/11/04
[37978.030188] ata6: status=0x51 { DriveReady SeekComplete Error }

