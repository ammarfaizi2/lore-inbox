Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHRScr>; Sun, 18 Aug 2002 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHRScr>; Sun, 18 Aug 2002 14:32:47 -0400
Received: from zork.zork.net ([66.92.188.166]:30381 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S315779AbSHRScq>;
	Sun, 18 Aug 2002 14:32:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode>
	<1029694235.520.9.camel@psuedomode> <6un0rkuiyg.fsf@zork.zork.net>
	<1029695363.1357.5.camel@psuedomode>
From: Sean Neakums <sneakums@zork.net>
Organization: The Emadonics Institute
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: HATE SPEECH, PROMOTION OF SELF
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 18 Aug 2002 19:36:47 +0100
In-Reply-To: <1029695363.1357.5.camel@psuedomode> (Ed Sweetman's message of
 "18 Aug 2002 14:29:23 -0400")
Message-ID: <6uhehsui80.fsf@zork.zork.net>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Ed Sweetman quotation:

> On Sun, 2002-08-18 at 14:20, Sean Neakums wrote:
>> commence  Ed Sweetman quotation:
>> 
>> > It appears i'm completely unable to not use devfs.  Attempting to
>> > run the kernel without mounting devfs results in it still being
>> > mounted or if not compiled in, locks up during boot.  Attempts to
>> > run the kernel and mv /dev does not work, umounting /dev does not
>> > work and rm'ing /dev does not work.  I cant create the non-devfs
>> > nodes while devfs is mounted and i cant boot the kernel without
>> > devfs.  It seems that no uninstall procedure has been made and i've
>> > read the documentation that comes with the kernel about devfs and it
>> > says nothing about how to move back to the old device nodes from
>> > devfs.
>> >
>> > anyone have any suggestions?
>> 
>> Where does the boot hang?  If it comaplains about not being able to
>> open /dev/console or some other device node, it may be that your /dev
>> has no nodes in it.  This happened to me when I eradicated devfs (I
>> got fed up of fighting with devfsd to get my permission changes to
>> stick, and had reshuffled FSes in the meantime) and so I booted from a
>> rescue disk, mounted my root FS and recreated the device nodes in
>> /mnt/dev.
>> 
>
> I know i have no device nodes.  I removed them all before installing
> devfs.

You must have been really keen on devfs.

> the devfs documentation says it doesn't need to have devfs mounted
> to work, but this doesn't seem to be true at all.

If it does say exactly that, then it is outrageously wrong.

> Hence my confusion. I know i can go download a bootable iso and get
> that burned and working but I shouldn't have to do that.

Uh, you deleted your devices nodes, and now you want to boot the
system without devfs.  You have to do precisely that, or something
equivalent.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
