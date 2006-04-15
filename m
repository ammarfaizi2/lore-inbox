Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDOXdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDOXdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWDOXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:33:09 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62801 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932164AbWDOXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:33:08 -0400
Date: Sat, 15 Apr 2006 17:33:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA Conflict with PATA DMA
In-reply-to: <61Y0s-AN-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Bill Waddington <william.waddington@beezmo.com>
Message-id: <444182B3.4050608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <61Y0s-AN-23@gated-at.bofh.it> <61UzA-43O-5@gated-at.bofh.it>
 <61Y0s-AN-25@gated-at.bofh.it> <61Y0s-AN-21@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Waddington wrote:
> On Sat, 15 Apr 2006 16:42:22 UTC, in fa.linux.kernel you wrote:
> 
>> Esben Stien wrote:
>>> I'm having problems enabling DMA for my PATA HD.
>>>
>>> hdparm -d1 /dev/hdb reports: 
>>> HDIO_SET_DMA failed: Operation not permitted
>>>
>>> Of course, I'm super user. Nothing is printed in dmesg. 
>>>
>>> I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
>>> ICH5. I also have a SATA hd in the computer and this only happens when
>>> the SATA hd is there. If I remove the SATA HD, then I can enable DMA
>>> for the PATA hd.
>> Disabled combined mode in BIOS.
> 
> If only that was possible on my fscking T43.  *sigh*

The other way around is to make libata handle the PATA devices. I'm not 
sure if the support for that on combined mode is in mainline or if you 
need Alan's libata PATA patch for that?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

