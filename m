Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUG0SxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUG0SxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUG0Sw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:52:58 -0400
Received: from mrout3.yahoo.com ([216.145.54.173]:58640 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S266554AbUG0Spk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:45:40 -0400
Message-ID: <4106A2AB.3040508@bigfoot.com>
Date: Tue, 27 Jul 2004 11:44:59 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <410450CA.9080708@hispalinux.es> <pan.2004.07.26.05.35.49.669188@dungeon.inka.de> <4104AB98.8070506@bigfoot.com> <20040727165517.GA7727@heliosphan.in.cryptobackpack.org>
In-Reply-To: <20040727165517.GA7727@heliosphan.in.cryptobackpack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Bryson wrote:
> On Sun, Jul 25, 2004 at 11:58:32PM -0700 or thereabouts, Erik Steffl wrote:
> 
>>>devfs allowes you to not have the driver loaded till you try to use it.
>>>so udev _cannot_ do what devfs does.
>>>
>>>still I agree that the way kernel/hotplug/udev work is much better and
>>>supporting the old style devfs works is not necessary. but please be
>>>honest about the differences.
>>
>>  which means that now iPod automatically connects to firewire (and 
>>looses info on random tracks, sometime some other settings), instead of 
>>only connecting when I try to actually access it (the device).
> 
> I have been using ipods with linux for about 3 years.
> And I see that it says "do not disconnect" even after I have unmounted
> the file system.  I just disconnect it at this point and have not
> had any problems.

   me neither (well, few times iPod locked up and I had to do the two 
finger salute (hold, then menu&play)), I just don't want it to connect 
in the first place, the reason being that once it connects it looses the 
track of random tracks (so that they start from scratch and then i get 
repeated songs) and from time to time contrast (and I almost can't see 
display with default contrast so I have to set the contrast again). not 
really a big deal but inconvenient.

   I know I can just handle the loading of the modules manually but I'd 
rather have it handled by the system (plus loading and unloading of 
modules manually has to be done by admin while automatic load/unload 
works for any user)

   And, of course, what's the point in having drivers loaded for devices 
I only use occasionally (iPod, digital camera)

>>  it looks like there is no user level (end user, not admin) control on 
>>when the device drivers are loaded anymore - or is there?
>>
>>  Is there any way to load drivers on demand (obviously it's not job of 
>>udev but whose job it is?). What about unloading them - I unmount the 
>>disk and i think the iPod is disconnecred but it still says connected - 
>>is there any way to disconnect it (I guess similar problems arise with 
>>other hotplug devices)
> 
> This has been discussed in length on lkml many times during the
> writing of udev.  IIRC the argument was something like:
>  "we shouldn't be unloading modules because the memory taken up by a
>  module in memory(a few k) isn't worth writing the code to save"
> 
> I also recall there was something about end user behavior, but I don't
> remember the details.  Read the archives.

   yeah, I've read some of it on lkml and elsewhere, just don't think 
it's a good idea. Sometime you just don't want the module loaded (one 
example is my usage of iPod), memory is only one (sometime, maybe often, 
negligible) reason.

   This looks like one of those 90% solutions that are so annoying (and 
that are fairly rare in free (libre) software which I personally use in 
large part because of its flexibility).

	erik

