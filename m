Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290286AbSAXUvl>; Thu, 24 Jan 2002 15:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290264AbSAXUvW>; Thu, 24 Jan 2002 15:51:22 -0500
Received: from ns.ithnet.com ([217.64.64.10]:7174 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290286AbSAXUvR>;
	Thu, 24 Jan 2002 15:51:17 -0500
Date: Thu, 24 Jan 2002 21:51:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Simen Thoresen" <simen-tt@online.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS and RAID5
Message-Id: <20020124215108.71602cb2.skraw@ithnet.com>
In-Reply-To: <200201242129150390.0006952E@mail.online.no>
In-Reply-To: <15440.22127.875361.718680@abasin.nj.nec.com>
	<20020124200645.53dca41c.skraw@ithnet.com>
	<15440.23830.178152.579775@abasin.nj.nec.com>
	<20020124204938.39fa1960.skraw@ithnet.com>
	<200201242129150390.0006952E@mail.online.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 21:29:15 +0100
"Simen Thoresen" <simen-tt@online.no> wrote:

> >Is anybody out there that ever survived a hd crash in SW RAID5 config?
> >(Meaning _without_ need to reboot)
> 
> Survived and survived....
> 
> I had a drive lose power (flaky connector) in a 4 drive setup (2x hpt370 dual channel controllers, each with a 30G IBM ide-drive on each channel - Using IDE and Raid-patches for 2.2.17). The result was a readable, but unwritable array. A streamed mp3 played flawlessly while the drive 'died', while my download (over smb) just froze.
> 
> Rebuilding the array (after a reboot) went ok, but during rebuild the 'new' drive appeared to be drive #5 in the 4-disk set, with drive #3 still dead. 

Why is it not writeable? What about a runtime fallover to a spare disk?

Regards,
Stephan



