Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTLBTn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLBTn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:43:27 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:57765 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S264330AbTLBTnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:43:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Buslogic driver warnings
Date: Tue, 2 Dec 2003 14:43:23 -0500
User-Agent: KMail/1.5.1
References: <20031202191632.GY11972@vnl.com>
In-Reply-To: <20031202191632.GY11972@vnl.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021443.23234.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.54.127] at Tue, 2 Dec 2003 13:43:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 December 2003 14:16, Dale Amon wrote:
>I noticed this when I started a test build for my workstation
>with hopes of moving it over to 2.6.0-test11:
>
>drivers/scsi/BusLogic.c: In function
> `BusLogic_InitializeProbeInfoListISA': drivers/scsi/BusLogic.c:700:
> warning: `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c:704: warning:
> `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c:708: warning:
> `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c:712: warning:
> `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c:716: warning:
> `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c:720: warning:
> `check_region' is deprecated (declared at
> include/linux/ioport.h:119) drivers/scsi/BusLogic.c: In function
> `BusLogic_InitializeMultiMasterProbeInfo':
> drivers/scsi/BusLogic.c:973: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
> drivers/scsi/BusLogic.c:988: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
> drivers/scsi/BusLogic.c:993: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
> drivers/scsi/BusLogic.c:998: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
> drivers/scsi/BusLogic.c:1003: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
> drivers/scsi/BusLogic.c:1008: warning: `check_region' is deprecated
> (declared at include/linux/ioport.h:119)
>
>Presumably someone is going to soon obsolete check_region,
>which will then break the Buslogic driver and most of
>my machines.
>
>Is anyone working on this driver these days?

Apparently not.  The driveres/scsi/Advansys.c driver suffers similarly 
from the "check_region" thingy, but only twice.  For the present, the 
effect is apparently a warning only.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

