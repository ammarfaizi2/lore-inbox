Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270405AbRHHHqU>; Wed, 8 Aug 2001 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270403AbRHHHqK>; Wed, 8 Aug 2001 03:46:10 -0400
Received: from [210.52.24.10] ([210.52.24.10]:7437 "HELO mx.linux.net.cn")
	by vger.kernel.org with SMTP id <S270405AbRHHHp4>;
	Wed, 8 Aug 2001 03:45:56 -0400
Date: Wed, 8 Aug 2001 15:46:53 +0800
From: Fang Han <dfbb@linux.net.cn>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: [Bug]No ATARAID chip, But ATARAID loaded
Message-ID: <20010808154653.B1355@dfbbb.cn.mvd>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <laughing@shared-source.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use 2.4.5-ac19 ( RedHat rawhide kernel 2.4.5-5 )
When I install it on an Machine with :

Dual PIII 700 + TYAN motherboard  512M ( No IDE RAID chips !)
70G IBM IDE HD connect to normal IDE 
2 channel Adaptec 7895 ( No Scsi disk connected )
1 Adaptec 2940 ( No Scsi disk connected )
Mylex DAC960 Raid with 3x38G Scsi disk (Raid5)

from booting message the Promise Software raid 0.02/ HPT370 Software 0.01
 ) driver loaded.  And it can see the partitions of 70G IDE HD,
All partition know as  ataraid1 ataraid5...
 But when mounting the root filesystem(in hda1) it complain IO 
error, Then kernl panic.

Is there any way to solve it?

Dfbb

