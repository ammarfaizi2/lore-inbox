Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290746AbSAYRgs>; Fri, 25 Jan 2002 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSAYRgi>; Fri, 25 Jan 2002 12:36:38 -0500
Received: from [212.3.242.3] ([212.3.242.3]:60427 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S290746AbSAYRg2>;
	Fri, 25 Jan 2002 12:36:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>
Subject: Re: Mounting OS-X "Unix" filesystems on Linux
Date: Fri, 25 Jan 2002 18:36:18 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020125171837.GA31376@tux.gsfc.nasa.gov>
In-Reply-To: <20020125171837.GA31376@tux.gsfc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020125173630Z290746-13996+12056@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 January 2002 18:18, John Kodis wrote:
> I'm trying to mount an OS-X Unix filesystem on Linux.  I haven't had
> any luck at this, and wondered whether this is a known problem, or if
> I'm doing something wrong.
>
> I formatted a zip disk on a Mac OS-X, selecting the "Unix" filesystem
> type and no partitions.  I then inserted this disk in the /dev/hdd,
> the zip drive on my PC.  I tried mounting hdd and hdd1 through hdd4
> using types of auto, ufs, udf, sysv, and one or two others, all to no
> avail.

My guess is that you'll probably need to compile support for 'advanced 
partitions', as you can find in menuconfig under Filesystems - Partition 
Types. I have no idea which one, though. That'll probably trail and error.

DK
