Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWBNQgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWBNQgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWBNQgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:36:05 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:23008 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1422634AbWBNQgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:36:04 -0500
thread-index: AcYxhLpvuPDoZVDaSD2R04/Ey2bBkw==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F206EC.2050906@bfh.ch>
Date: Tue, 14 Feb 2006 17:35:56 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <Pine.LNX.4.61.0602131410400.17242@chaos.analogic.com> <43F0DFCC.5020404@cfl.rr.com>
In-Reply-To: <43F0DFCC.5020404@cfl.rr.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 16:35:55.0692 (UTC) FILETIME=[BA413EC0:01C63184]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Phillip Susi wrote:
> linux-os (Dick Johnson) wrote:
> 
>> You can make your own:
>>
>> Pretend a sector is 512 bytes.
>> Use the maximum number of cylinders of either 65535 or 1024
>> Use the maximum number of sectors up to 255
>> Use the maxumum number of heads up to 255
>>
>>
>> Try the above with 1024 cylinders first. If it doesn't fit, use
>> 65535. That's all the BIOS does. It's just used to fit the
>> stuff into registers for 16-bit BIOS calls (see int 0x13).
>>
>>   
> 
> 
> Actually, different bioses do it in different ways, that is just one way
> ( and possibly the most popular ).  The same bios can even do it
> differently depending on what options are selected in the bios setup. 
> Of course, this only effects Microsoft operating systems because
> everyone else is sane and supports LBA.

With emphasis on _sane_
