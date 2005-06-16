Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVFPPLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVFPPLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVFPPLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:11:03 -0400
Received: from lucidpixels.com ([66.45.37.187]:56458 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S261677AbVFPPKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:10:54 -0400
Date: Thu, 16 Jun 2005 11:10:53 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Lee Revell <rlrevell@joe-job.com>
cc: Michael Heyse <mhk@designassembly.de>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
In-Reply-To: <1118933954.2644.8.camel@mindpipe>
Message-ID: <Pine.LNX.4.63.0506161110280.15642@p34>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain> 
 <42B14415.5060105@designassembly.de> <Pine.LNX.4.63.0506160523190.6459@p34>
 <1118933954.2644.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jun 2005, Lee Revell wrote:

> On Thu, 2005-06-16 at 05:24 -0400, Justin Piszcz wrote:
>> Alan followed up with me but we did not reach any conclusion as to what
>> was causing it to crash.  The main way I got it to crash was dd
>> if=/dev/hde (root drive) of=/nfs/file.img bs=1M, I have not had any issues
>> as far as copying files and such.  For you, is it on a particular box or
>> boxes, have you tried copying the other direction?  I use NFS over UDP btw
>> (v3).
>>
>> # mount
>> mount:/disk/1 on /remote/1 type nfs
>> (rw,hard,intr,nfsvers=3,addr=192.168.168.253)
>
> Are you both using NFS + software RAID?  Is 4KSTACKS enabled?
>
> IIRC people were getting stack overflows with the NFS + RAID + 4K stacks
> combination.
>
> Lee
>

I was not using any type of RAID, SW or HW.
4K stacks was not enabled on either machine.

I am using XFS though.

