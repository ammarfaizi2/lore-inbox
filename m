Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290346AbSAXVtM>; Thu, 24 Jan 2002 16:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290343AbSAXVtC>; Thu, 24 Jan 2002 16:49:02 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:18956 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S290361AbSAXVsr>;
	Thu, 24 Jan 2002 16:48:47 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.33076.451427.886741@abasin.nj.nec.com>
Date: Thu, 24 Jan 2002 16:48:36 -0500 (EST)
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Simen Thoresen" <simen-tt@online.no>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS and RAID5
In-Reply-To: <20020124215108.71602cb2.skraw@ithnet.com>
In-Reply-To: <15440.22127.875361.718680@abasin.nj.nec.com>
	<20020124200645.53dca41c.skraw@ithnet.com>
	<15440.23830.178152.579775@abasin.nj.nec.com>
	<20020124204938.39fa1960.skraw@ithnet.com>
	<200201242129150390.0006952E@mail.online.no>
	<20020124215108.71602cb2.skraw@ithnet.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > On Thu, 24 Jan 2002 21:29:15 +0100
 > "Simen Thoresen" <simen-tt@online.no> wrote:
 > 
 > > >Is anybody out there that ever survived a hd crash in SW RAID5 config?
 > > >(Meaning _without_ need to reboot)
 > > 
 > > Survived and survived....
 > > 
 > > I had a drive lose power (flaky connector) in a 4 drive setup (2x hpt370 dual channel controllers, each with a 30G IBM ide-drive on each channel - Using IDE and Raid-patches for 2.2.17). The result was a readable, but unwritable array. A streamed mp3 played flawlessly while the drive 'died', while my download (over smb) just froze.
 > > 
 > > Rebuilding the array (after a reboot) went ok, but during rebuild the 'new' drive appeared to be drive #5 in the 4-disk set, with drive #3 still dead. 
 > 
 > Why is it not writeable? What about a runtime fallover to a spare disk?
 > 

runtime fallover to the spare disk did not work for me until the
reboot.  And even then after the reboot my data was recoverable, but
as describe by my first post, didn't last for long.

    Sven
