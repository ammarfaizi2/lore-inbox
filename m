Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933640AbWK3Jub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640AbWK3Jub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWK3Jub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:50:31 -0500
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59]:458 "EHLO
	rzcomm12.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S933640AbWK3Jub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:50:31 -0500
Message-ID: <456EA95C.8070301@l4x.org>
Date: Thu, 30 Nov 2006 10:50:20 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Thunderbird 2.0b1pre (Windows/20061126)
MIME-Version: 1.0
To: tao@acc.umu.se
CC: Robert Hancock <hancockr@shaw.ca>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mass-storage problems with Archos AV500
References: <fa.+HViQkzstd1WGzxw6QnaK2a1tiY@ifi.uio.no> <456E5F91.7020300@shaw.ca> <20061130085356.GV14886@vasa.acc.umu.se>
In-Reply-To: <20061130085356.GV14886@vasa.acc.umu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Wed, Nov 29, 2006 at 10:35:29PM -0600, Robert Hancock wrote:
>> David Weinehall wrote:
>>> I've got an Archos AV500 here (running the very latest firmware), pretty
>>> much acting as a doorstop, since I cannot get it to be recognized
>>> properly by Linux.
>> ..
>>
>>> [  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
>>> MB)
>>> [  118.144000] sdb: Write Protect is off
>>> [  118.144000] sdb: Mode Sense: 33 00 00 00
>>> [  118.144000] sdb: assuming drive cache: write through
>>> [  118.144000]  sdb: unknown partition table
>>> [  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb
>>> [  118.452000] usb-storage: device scan complete
>>>
>>> This is with linux-image-2.6.19-7-generic 2.6.19-7.10 from Ubuntu edgy.
>>> I get similar results with a home-brew 2.6.18-rc4.
>>>
>>> Any mass storage quirk needed that might be missing?
>> That all seems normal, other than the unknown partition table, but the 
>> device might be all one unpartitioned disk.. at what point is it failing?
> 
> Mounting it just claims wrong FS type.  And I've tried most file systems
> I can think of just to be sure.

Can you read the whole volume with 'dd'? If yes, you could provide
a hex dump of the first few sectors? Probably someone on this list will
recognize the format...

Jan
