Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267369AbTACBXD>; Thu, 2 Jan 2003 20:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTACBXD>; Thu, 2 Jan 2003 20:23:03 -0500
Received: from zork.zork.net ([66.92.188.166]:41156 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267369AbTACBXC>;
	Thu, 2 Jan 2003 20:23:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: mkfs help, please.
References: <0H84002VD4UUI0@mtaout07.icomcast.net>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: ARGUMENTUM AD HOMINEM, ADULT
 LANGUAGE/SITUATIONS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 02 Jan 2003 17:31:32 -0800
In-Reply-To: <0H84002VD4UUI0@mtaout07.icomcast.net> (Jerry McBride's message
 of "Thu, 02 Jan 2003 19:50:03 -0500")
Message-ID: <6ud6nf81e3.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Jerry McBride quotation:

> I'm setting up a new computer with a 60gig maxtor. I'd like a 100meg /boot at
> the very top of the disk to get around 1024 cylinder bios restriction with out
> have to do anything special. This has to be as vanilla as possible.

What do you mean by "top"?

The /boot partition should be towards the front of the disk, i.e. with
a low starting cylinder number.

For example, my /boot is /dev/hda2:

# fdisk -l /dev/hda

Disk /dev/hda: 30.0 GB, 30005821440 bytes
255 heads, 63 sectors/track, 3648 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
...
/dev/hda2             1         3     24066   83  Linux
...

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
