Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263373AbTCNPi2>; Fri, 14 Mar 2003 10:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbTCNPi2>; Fri, 14 Mar 2003 10:38:28 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:45953 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S263373AbTCNPi0>;
	Fri, 14 Mar 2003 10:38:26 -0500
Message-ID: <3E71F9CB.706@beam.ltd.uk>
Date: Fri, 14 Mar 2003 15:48:27 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: mmadore@aslab.com, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com>
In-Reply-To: <1999490000.1047653585@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Thanks for the info.
We were using these drivers as:

1. The 1.0.0 driver is as used in the Stock Redhat 7.3 release (updated
	to current updates).
2. The 1.1.0 driver is on the Adaptec web site for Linux and is I 		 
believe the one shipped on there CDROM for the on-board 7902
	controller.

We were not aware of a later driver.
For future reference, where should we go to find the latest drivers
for any device for the linux 2.4.x kernel ?

Do you know if the latest driver at 
http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
might fix this problem ?

Cheers

Terry

Justin T. Gibbs wrote:
>>Our system is:
>>System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
>>SCSI: Adaptec 7902 onboard dual channel SCSI controller
>>Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
>>Disks: 1 off Seagate ST336607LW 36G (320LW)
>>System: RedHat 7.3 with updates to 18/02/03
>>Kernel: 2.4.18-24.7.xsmp
>>Aic79xx Driver: versions 1.0.0 and 1.1.0
> 
> 
> Is there some reason why you are using such old versions of the aic79xx
> driver?  You can obtain the latest version of the driver from here:
> 
> http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
> http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/
> 
> or in source form for a 2.4.X or 2.5.X kernel from here:
> 
> http://people.freebsd.org/~gibbs/linux/SRC/
> 
> --
> Justin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

