Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131042AbRAQTD2>; Wed, 17 Jan 2001 14:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRAQTDS>; Wed, 17 Jan 2001 14:03:18 -0500
Received: from janus.cypress.com ([157.95.1.1]:9714 "EHLO janus.cypress.com")
	by vger.kernel.org with ESMTP id <S131042AbRAQTDC>;
	Wed, 17 Jan 2001 14:03:02 -0500
Message-ID: <3A65EC18.A74A544D@cypress.com>
Date: Wed, 17 Jan 2001 13:01:44 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: david <sector2@ihug.co.nz>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: need help raid and 2.4.0
In-Reply-To: <3A65D60E.188C88E6@ihug.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david wrote:
> 
> hi i am moving from 2.2.18 to 2.4.0 i have a ide raid set but can not
> get it to run under 2.4.0
> i user mdadd / mdrun to config it. in raid-tools 0.42 but it dose not
> come up under 2.4.0 it just says unknow devices /dev/hda3 & /dev/hdc3
> but thay are thear and when i try to compile raid-tools .53 undir 2.4.0
> i get a lot of error in string.h (i am runing debian 2.2r2)
> i configured the kernel

First, did the IDE driver detect the disks/partitions listed?
what does /proc/partitions, /proc/modules, and /proc/ioports
show in 2.4.0?

I switched from 2.2.x -> 2.4.0 with IDE RAID disks fine.
Using the RedHat7.0 default of raidtool-0.90
Try building the newer raidtools and make sure to use the
correct kernel headers (the ones for 2.4.0)

	-Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
