Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSDZPZC>; Fri, 26 Apr 2002 11:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSDZPZB>; Fri, 26 Apr 2002 11:25:01 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:20625 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S314065AbSDZPZB>;
	Fri, 26 Apr 2002 11:25:01 -0400
Message-ID: <3CC970E2.2030407@bcgreen.com>
Date: Fri, 26 Apr 2002 08:23:14 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <3CC738AD.50905@bcgreen.com> <Pine.LNX.3.96.1020424232237.4586B-100000@gatekeeper.tmr.com> <20020426040457.GO574@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think it has to do with the IRQs, but it sounds like the entire ide
> chipset (think two cables one one chipset...) has stopped responding when
> ONE device (out of a possible four (with two cables)) has failed media.

In my case, I was able to read data from hda while the cdrom
on hdd was trying to recover data from a scratched disk.
Reading data from hdc (shared cable with the CDROM), on the
other hand, was VERY slow.

I have an 82371AB PIIX4 ide interface (dual IDE chipset),
It's part of a 440BX chipset board.

If accessing on one IDE interface (C/D) causes the other (A/B) to lockup,
I'd guess you've got especially cheap hardware on your box.

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

