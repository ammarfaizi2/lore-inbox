Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264713AbSJ3Phk>; Wed, 30 Oct 2002 10:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSJ3Phk>; Wed, 30 Oct 2002 10:37:40 -0500
Received: from secondary.dns.nitric.com ([64.81.197.162]:9600 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id <S264713AbSJ3Phj>; Wed, 30 Oct 2002 10:37:39 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
From: merlin <merlin@merlin.org>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:819 with 2.5.44-ac5 
In-reply-to: <20021030143502.GK3416@suse.de> 
Date: Wed, 30 Oct 2002 10:43:59 -0500
Message-Id: <20021030154359.1C107868F0@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r/axboe@suse.de/2002.10.30/15:35:02
>On Wed, Oct 30 2002, merlin hughes wrote:
>> Hi,
>> 
>> Tyan Tiger S2466-4M, 2xAthlon MP, Adaptec 29160, Adaptec 2940u2w,
>> software RAID 5, gcc 2.95.4. The core drives are on the 29160. Works
>> fine under 2.4.19.
>> 
>> 2.5.44 panics during boot with SCSI problems; I didn't catch what the
>> error was.
>> 
>> 2.5.44-ac5 boots but bugs after a few seconds.
>> 
>> Attached: config, syslog, lspci (under 2.4.19)
>> 
>> Oct 28 12:36:09 badb kernel: Incorrect number of segments after building lis
>t
>> Oct 28 12:36:09 badb kernel: counted 2, received 1
>> Oct 28 12:36:09 badb kernel: req nr_sec 8, cur_nr_sec 8
>
>Please try 2.5.44-BK and see if that works, James fixed this one.

If that's equivalent to 2.5.44 +
http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/cset-1.808-to-1.869.txt.gz
then I get the same error (incorrect number of segments...). It happened
earlier in the boot process so I couldn't catch the details; it looked
like it oopsed along with everything else.

Thanks, Merlin
