Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274680AbRJAHg6>; Mon, 1 Oct 2001 03:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJAHgs>; Mon, 1 Oct 2001 03:36:48 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:47623 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S274680AbRJAHgg>;
	Mon, 1 Oct 2001 03:36:36 -0400
Date: Mon, 1 Oct 2001 09:36:48 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Evan Harris <eharris@puremagic.com>
cc: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
In-Reply-To: <Pine.LNX.4.33.0110010113420.2459-100000@kinison.puremagic.com>
Message-ID: <Pine.LNX.4.33.0110010934330.20107-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Evan Harris wrote:

>
> md0 : active raid5 sde1[6] sdi1[5] sdh1[4] sdg1[3] sdf1[2] sdd1[0]
>       179203840 blocks level 5, 256k chunk, algorithm 0 [6/5] [U_UUUU]
>       [=>...................]  recovery =  8.4% (3023688/35840768)
> finish=88.9min speed=6148K/sec
>
> Now, my question is: the hotadd seems to have reordered the disks, so when
> the rebuild is completed, do I need to reorder my raidtab to reflect this?
> Like this?

Once the resync has completed the hotadded disk will drop into its slot.
Ie there is no need to change the numbers in /etc/raidtab, they wil be
correct once the array has recovered.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


