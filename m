Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVIFGvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVIFGvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVIFGvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:51:17 -0400
Received: from lisa.usl6.toscana.it ([159.213.44.2]:51371 "EHLO
	lisa.nord.usl6.toscana.it") by vger.kernel.org with ESMTP
	id S932424AbVIFGvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:51:16 -0400
Message-ID: <001e01c5b2af$7ebb4430$1f01a8c0@Ric>
Reply-To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
From: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
To: "Stephen C. Tweedie" <sct@redhat.com>,
       "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Cc: "Stephen Tweedie" <sct@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <007b01c5b236$5b6019d0$1f01a8c0@Ric> <1125944400.1910.19.camel@sisko.sctweedie.blueyonder.co.uk>
Subject: Re: EXT3-fs error (device hda8): ext3_free_blocks: Freeing blocksnot in datazone
Date: Tue, 6 Sep 2005 08:52:06 +0200
Organization: Azienda USL 6 - Livorno
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run memtest86 and It gives errors.
I removed the installed 256 MB RAM of 512 MB and now PC works.

thanks


----- Original Message ----- 
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Cc: "Stephen Tweedie" <sct@redhat.com>; "linux-kernel" 
<linux-kernel@vger.kernel.org>
Sent: Monday, September 05, 2005 8:20 PM
Subject: Re: EXT3-fs error (device hda8): ext3_free_blocks: Freeing 
blocksnot in datazone


> Hi,
>
> On Mon, 2005-09-05 at 17:24, Riccardo Castellani wrote:
>> I'm using FC3 with Kernel 2.6.12-1.1376.
>> After few hours file system on /dev/hda8 EXT3 partition has a problem so 
>> it
>> remounted in only read mode.
>
>> Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8): 
>> ext3_free_blocks:
>> Freeing blocks not in datazone - block = 134217728, count = 1
>
> That block number is 0x8000000 in hex.  It's a single-bit flip error;
> that strongly sounds like hardware, and I'd run memtest86 on that box
> next.
>
>> Sep  5 17:34:40 mrtg kernel: Aborting journal on device hda8.
>> Sep  5 17:34:40 mrtg kernel: EXT3-fs error (device hda8) in
>> ext3_reserve_inode_write: Journal has aborted
> ...
>
>> I tried several times to run fsck on this partition and I also tried to
>> remount fs in a new partition, but it happened nothing !
>
> What do you mean?  fsck found nothing wrong?  remount failed?  You _did_
> unmount before fscking, did you?
>
> --Stephen
>>
> 

