Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWBOOQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWBOOQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWBOOQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:16:27 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:10193 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932092AbWBOOQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:16:27 -0500
thread-index: AcYyOa0uD3FTdDYKRfa7GCaGhi4Efw==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F3367F.8020807@bfh.ch>
Date: Wed, 15 Feb 2006 15:11:11 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       "Phillip Susi" <psusi@cfl.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <43F2EE04.9060500@bfh.ch> <1140012392.14831.13.camel@localhost.localdomain>
In-Reply-To: <1140012392.14831.13.camel@localhost.localdomain>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 14:11:12.0405 (UTC) FILETIME=[AD068C50:01C63239]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> On Mer, 2006-02-15 at 10:01 +0100, Seewer Philippe wrote:
> 
>>This would mean dropping the HDIO_GETGEO ioctl completely and force
>>applications such as fdisk/sfdisk and even dosemu to determine disk
>>geometry for themselves. Which I think actually would be the most
>>correct approach.
> 
> 
> In the IDE case the drive geometry has meaning in certain cases,
> specifically the C/H/S drive addressing case with old old drives. 
> 
> 
Yes. But the addressing is abstracted by the kernel and we where talking
about dropping the getgeo ioctrl. Not geometry itself.
