Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290138AbSAXUab>; Thu, 24 Jan 2002 15:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290156AbSAXUaU>; Thu, 24 Jan 2002 15:30:20 -0500
Received: from mail50-s.fg.online.no ([148.122.161.50]:9609 "EHLO
	mail50.fg.online.no") by vger.kernel.org with ESMTP
	id <S290138AbSAXUaF> convert rfc822-to-8bit; Thu, 24 Jan 2002 15:30:05 -0500
Message-ID: <200201242129150390.0006952E@mail.online.no>
In-Reply-To: <20020124204938.39fa1960.skraw@ithnet.com>
In-Reply-To: <15440.22127.875361.718680@abasin.nj.nec.com>
 <20020124200645.53dca41c.skraw@ithnet.com>
 <15440.23830.178152.579775@abasin.nj.nec.com>
 <20020124204938.39fa1960.skraw@ithnet.com>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Thu, 24 Jan 2002 21:29:15 +0100
From: "Simen Thoresen" <simen-tt@online.no>
To: skraw@ithnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS and RAID5
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is anybody out there that ever survived a hd crash in SW RAID5 config?
>(Meaning _without_ need to reboot)

Survived and survived....

I had a drive lose power (flaky connector) in a 4 drive setup (2x hpt370 dual channel controllers, each with a 30G IBM ide-drive on each channel - Using IDE and Raid-patches for 2.2.17). The result was a readable, but unwritable array. A streamed mp3 played flawlessly while the drive 'died', while my download (over smb) just froze.

Rebuilding the array (after a reboot) went ok, but during rebuild the 'new' drive appeared to be drive #5 in the 4-disk set, with drive #3 still dead. 

>(I only try to figure out what is going on, because I am heavily 
>interested in building RAID5 configs myself, and you would not want to
>touch components (SW or HW) in this case that you cannot not trust)
>

Seems to work ok on 2.2.17 at least (had problems with 2.2.19 as detailed previously) - untried with 2.2.20 or 2.4 so far.

It's fun tho :-)

-S
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


