Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbRANE5p>; Sat, 13 Jan 2001 23:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRANE5f>; Sat, 13 Jan 2001 23:57:35 -0500
Received: from smtp.hattaway-associates.com ([203.79.82.65]:21219 "EHLO
	server01.hattaway-associates.com") by vger.kernel.org with ESMTP
	id <S130357AbRANE5W>; Sat, 13 Jan 2001 23:57:22 -0500
Message-ID: <3A61315C.37318059@hattaway-associates.com>
Date: Sun, 14 Jan 2001 17:55:56 +1300
From: Godfrey Livingstone <godfrey@hattaway-associates.com>
Organization: Hattaway & Associates
X-Mailer: Mozilla 4.72 [en] (Win98; I)
X-Accept-Language: en-GB,en
MIME-Version: 1.0
To: Jens Petersohn <jkp@mccoy.penguinpowered.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
In-Reply-To: <200101112136.PAA07626@mccoy.penguinpowered.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There is as yet no official patch for raid 0.90 for 2.2.18

This question would be better asked on  linux raid list
linux-raid@vger.kernel.org.

You can apply the patches below.

If you apply the following you get the raid patched kernel.

 http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre25/VM-global-2.2.18pre25-7.bz2

You MUST apply this patch before the two raid patches. The VM patch stablises
the 2.2.18 virtual memory system and if you don't apply my two repackaged
patches will fail. The above VM patch has been accepted into 2.2.19pre3 and
many people are using it so is not untested.

Raid patches.

 http://www.hattaway-associates.com/raidpatches/raid-2.2.18-A2.bz2

For faster raid 1

 http://www.hattaway-associates.com/raidpatches/raid1readbalance-2.2.18.bz2

Hope this helps

Godfrey Livingstone



Jens Petersohn wrote:

> My appologies if this has been asked before. I'm looking for
> Ingo Molnar's RAID patch for 2.2.18-final. I tried applying A2, but
> it has a number of conflicts in raid1.c which I cannot resolve in
> my meager spare time.
>
> Thanks in advance,
>
> --Jens Petersohn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
