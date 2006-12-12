Return-Path: <linux-kernel-owner+w=401wt.eu-S1751585AbWLLUlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWLLUlf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWLLUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:41:35 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:59872 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbWLLUle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:41:34 -0500
Message-ID: <457F0F7D.9090207@wolfmountaingroup.com>
Date: Tue, 12 Dec 2006 13:22:21 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Andrew Robinson <andrew.rw.robinson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with
 SATA and should not be used by any meansis not stable with SATA and should
 not be used by any means)
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com> <457F02D3.5010004@cfl.rr.com>
In-Reply-To: <457F02D3.5010004@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> Andrew Robinson wrote:
>
>> Now I am confused on what may be the cause of the corruption. Could it
>> have been just a ReiserFS problem (I will be using Ext3 or JSF on my
>> next rebuild I think after reading some reviews on the ReiserFS and
>> this recent experience).
>
>
> I have been running reiser on  my home machine and a server at work 
> for a year now without incident.  There were some bugs a few years 
> back but it seems to be in good working order these days.
>
>> I'm not sure if it could be a SATA_NV driver problem, a hibernate
>> problem, or a ReiserFS problem or a combination of the above. For
>> hibernation, I had the resume2 kernel boot option set as /dev/sda1 (my
>> swap partition). I do not have suspend2 installed though, I have been
>> relying on its fallback settings to ususpend or sysfs (not sure which
>> one is actually executed).
>
>
> Sounds like your hibernation corrupted the disk, but without more 
> specifics, this is just educated guesswork.
>
No.  I still see corruption on Suse with Reiser FS.  It's always very 
subtle (like the last block of a file doesn;t get copied or gets
corrupted.   We have been running our ftp server on ReiserFS, and as 
soon as I can get it moved back to ext3, we are doing so.
We have had a lot of issues with corrupted RPM files and builds on 
ReiserFS.  If you can get the files copied to the
FS ok, they seem to stay that way.  moving a lot of data with recursive 
copies seems troublesome and some of the files
seem to get the ends clipped off of them.

Jeff
