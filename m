Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWBPISk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWBPISk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 03:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWBPISk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 03:18:40 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:37254 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932515AbWBPISj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 03:18:39 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYy0YpBbdPsEanWRny2gK+D+9N3oA==
Message-ID: <43F43548.4090700@bfh.ch>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Date: Thu, 16 Feb 2006 09:18:16 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Phillip Susi" <psusi@cfl.rr.com>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain>
In-Reply-To: <1140024754.14831.31.camel@localhost.localdomain>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 08:18:17.0170 (UTC) FILETIME=[8A03DB20:01C632D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> On Mer, 2006-02-15 at 11:20 -0500, Phillip Susi wrote:
> 
>>Why do you say the partitioning tool needs to know the disk reported 
>>C/H/S?  The value stored in the MBR must match the bios reported values, 
>>not the disk reported ones, so why does the partitioner care about what 
>>the disk reports?
> 
> 
> You answered that in asking the question.  "The value stored in the MBR
> must match the ...". What if the MBR has not yet been written ?
> 
> (Also btw its *should*...) most modern OS's will take a sane MBR
> geometry and trust it over BIOS defaults.
not always. to dos based winnt.exe installer for windows xp trusts the
bios, not the mbr
> 
> Alan
> 
