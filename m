Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTL2KQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 05:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTL2KQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 05:16:25 -0500
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:33990 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262731AbTL2KQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 05:16:23 -0500
Message-Id: <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
X-Nil: 
Date: Mon, 29 Dec 2003 21:16:12 +1100
To: sflory@rackable.com
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel 
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FEF721D.7020405@rackable.com>
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
 <3FEF721D.7020405@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  At 11:15 AM 29/12/2003, Samuel Flory wrote:
>Leon Toh wrote:
>
>>Merry Christmas Everyone,
>>I just downloaded full source code of linux-2.6.0 to start doing some 
>>work and testing of  Adaptec/DPT I2O controller's. This is when I happen 
>>to notice Adapec/DPT I2O option have been omitted from Linux Kernel 2.6.0 
>>Configuration tool.
>>Typically this option is located in *Device Drivers -> SCSI device 
>>support -> SCSI low-level drivers*. Furthermore it is also not listed in 
>>*Device Drivers -> I2O device support* also. And the driver source 
>>(dpti2o) is residing in /drivers/scsi.
>>Please advice how should I than go about in hacking Linux 2.6.0 Kernel 
>>Configuration tool to include Adaptec/DPT I2O support ?
>>Also any reason for the Adaptec/DPT I2O option being omitted out from 
>>Linux Kernel configuration tool  ? Or is it just happen to be accidental 
>>? Will this be option made available in the next release or pre-release 
>>of 2.6 kernel than ?
>
>   The DPT I2O driver was never converted to the new driver model.  The 
> driver from what I can see is a mess.

How broken is the driver than ? What are the implication's if the driver is 
left as it is for now ?

>It doesn't even compile in 2.4 for a number of archs like amd64.

This driver was initially intended only for i386 arch. Furthermore at that 
time when this driver was finalized amd64 wasn't available.

>   A while back  a bunch of people (including myself) raised the concern 
> through various channels with adaptec.  In theroy someone at adaptec is 
> working on it, but there was not an ETA.

If you have happen to have a list of issues with this current driver 
together with supporting information to back up those claims, please 
forward them to so that I can escalate those issues into Adaptec via the 
appropriate communication channel. I happen to have a number of contact's 
within Adaptec myself.

By the way I've hack the script file to make Adaptec I2O Option to appear 
in Linux 2.6.0 Kernel Configuration tool. Currently I'm now in the middle 
of recompiling the kernel using current dpti2o driver support but haven't 
got to the dpti2o driver yet. 

