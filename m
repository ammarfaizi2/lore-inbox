Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWBWWyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWBWWyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWBWWyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:54:17 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:1719 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751800AbWBWWyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:54:17 -0500
Message-ID: <43FE3D16.3000707@comcast.net>
Date: Thu, 23 Feb 2006 17:54:14 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
References: <1140445182.26526.1.camel@localhost.localdomain>	 <43FD347B.6030802@comcast.net> <1140707265.4332.6.camel@localhost.localdomain> <43FDF6F0.6000006@bootc.net>
In-Reply-To: <43FDF6F0.6000006@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patchset (ide2) i'm able to boot.  I'm still unable to fixate 
cds, however.  Even with the patchset from Garzik that was posted 
before.  Though, with Garzik's patch, i recieve no errors in dmesg 
output.  Prior to Garzik's patch i recieved this error when fixating discs.


Feb 22 17:37:23 psuedomode kernel: Assertion failed! qc->n_elem > 
0,drivers/scsi/libata-core.c,ata_fill_sg,line=2586


(yes i know psuedo is spelled wrong)

Chris Boot wrote:

> Alan Cox wrote:
>
>> On Mer, 2006-02-22 at 23:05 -0500, Ed Sweetman wrote:
>>
>>> With this patch set and the attached config.  Nvidia Nforce4 chipset 
>>> from asus A8N-E with pata and sata enabled (no ide drivers) I get 
>>> the following error i copied by hand (half assed) during bootup.
>>>
>>> Process Swapper  "lots of addresses"
>>
>>
>> Thanks for all the reports on the oops on boot. I was able to duplicate
>> it and fix the dumb bug that caused it.
>>
>> New patch (2.6.16-rc4-ide2)
>>
>>     http://zeniv.linux.org.uk/~alan/IDE
>
>
> -ide2 fixes my boot-time oops as well, cheers.
>
> Chris
>



