Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWBNVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWBNVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422817AbWBNVt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:49:58 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:1754 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1422815AbWBNVt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:49:57 -0500
Message-ID: <43F25089.2020109@dgreaves.com>
Date: Tue, 14 Feb 2006 21:50:01 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Is my SATA/400GB drive dying?
References: <Pine.LNX.4.64.0602130658110.21652@p34> <Pine.LNX.4.64.0602132018290.2607@p34> <20060214104345.GM3209@harddisk-recovery.com> <200602141930.45368.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602141930.45368.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Tuesday 14 February 2006 10:43, Erik Mouw wrote:
>  
>
>>On Mon, Feb 13, 2006 at 08:18:47PM -0500, Justin Piszcz wrote:
>>    
>>
>>>Still get the errors:
>>>
>>>[ 2311.980127] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ
>>>0xb/00/00
>>>[ 2311.980134] ata3: status=0x51 { DriveReady SeekComplete Error }
>>>[ 2311.980138] ata3: error=0x04 { DriveStatusError }
>>>      
>>>
>>FWIW, this could be related to smartctl trying to monitor the disk.
>>Try this:
>>
>>  smartctl -d ata -a /dev/sdX
>>
>>If that complains about SMART being disabled, enable it with:
>>
>>  smartctl -d ata -e /dev/sdX
>>    
>>
>
>Are you sure this isn't something obvious like an insufficiently large power 
>supply in the system? I've had strange SATA errors before because I was 
>running 4 HDs and a 6600GT on a 360W PSU.
>
>  
>
I have very similar problems - I spent £70ish on a decent branded,
reviewed 500W PSU and *still* have the exact same problems.

David

-- 

