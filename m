Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270436AbRHHJf6>; Wed, 8 Aug 2001 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270435AbRHHJfs>; Wed, 8 Aug 2001 05:35:48 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:63889 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S270436AbRHHJfm>; Wed, 8 Aug 2001 05:35:42 -0400
Importance: Normal
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: arjanv@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC92557FF.2232CB90-ONC1256AA2.0034783B@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 8 Aug 2001 11:36:00 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/08/2001 11:35:41
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> I tried the Patch from http://www.zip.com.au/~akpm/ext3-2.4-0.9.5-247.gz
>> with the kernel 2.4.7 with a new LVM- patch(0.9.1)  and some S/390
specific
>> patches. I use mke2fs version 1.22.
>> S/390 is a 32bit big endian machine. After compiling and running the
kernel
>> I created an ext3-file system on an 70GB LVM. When running the postmark
>> test I get (reproduceable) the message from above. dmesg shows:
>
>It would be interesting to know if this still happends without a beta
>version of LVM,
>and without LVM at all.

I will try it. But if I mount the same file system as ext2 (mount ... -t
ext2) the test succeeds, so I guess it is not LVM specific. I will inform
you if I know the result.

greetings


