Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263385AbTCNQIB>; Fri, 14 Mar 2003 11:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbTCNQIB>; Fri, 14 Mar 2003 11:08:01 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:51841 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S263385AbTCNQH7>;
	Fri, 14 Mar 2003 11:07:59 -0500
Message-ID: <3E7200B7.6000907@beam.ltd.uk>
Date: Fri, 14 Mar 2003 16:17:59 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Michael Madore <mmadore@aslab.com>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com> <3E7200D1.3030207@aslab.com>
In-Reply-To: <3E7200D1.3030207@aslab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

The Seagate ST336607LW has firmware: 0004.
Seagate have stated to me that this is the latest.
They have also stated to me:

  Issuing an unrecognized or illegal command to the drive can cause the
  drive to go into a hardware fault mode where it will no longer respond,
  and may or may not respond to a SCSI BUS reset. It seems, in this case,
  the drive will no longer respond to any commands issued by the
  controller.

Is this "feature" now common on SCSI drives ????

Terry

Michael Madore wrote:
> Also, what version of firmware do your drives have?  Our original 
> problems stemmed from buggy firmware.  Seagate have updated firmware 
> which you can request from their technical support.
> 
> Mike
> 
> Justin T. Gibbs wrote:
> 
>>> Our system is:
>>> System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
>>> SCSI: Adaptec 7902 onboard dual channel SCSI controller
>>> Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
>>> Disks: 1 off Seagate ST336607LW 36G (320LW)
>>> System: RedHat 7.3 with updates to 18/02/03
>>> Kernel: 2.4.18-24.7.xsmp
>>> Aic79xx Driver: versions 1.0.0 and 1.1.0
>>>   
>>
>>
>> Is there some reason why you are using such old versions of the aic79xx
>> driver?  You can obtain the latest version of the driver from here:
>>
>> http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
>> http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/
>>
>> or in source form for a 2.4.X or 2.5.X kernel from here:
>>
>> http://people.freebsd.org/~gibbs/linux/SRC/
>>
>> -- 
>> Justin
>>  
>>
> 
> 
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

