Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSFKFBX>; Tue, 11 Jun 2002 01:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSFKFBW>; Tue, 11 Jun 2002 01:01:22 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:8321
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316824AbSFKFBV>; Tue, 11 Jun 2002 01:01:21 -0400
Subject: Re: Locking CD tray w/o opening device
From: Austin Gonyou <austin@digitalroadkill.net>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206110328.g5B3SgL08447@marc2.theaimsgroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 11 Jun 2002 00:00:45 -0500
Message-Id: <1023771645.1519.3.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could echo "1" >/proc/sys/dev/cdrom/lock

If you do this, even when a cd is *not* in the drive it will be locked.
For information like this, it might be best to open xchat, and head to
openprojects.net and join #linuxhelp. This is a good question, just
perhaps  not right for the lkml?

:)


On Mon, 2002-06-10 at 22:28, Hank Leininger wrote:
> On 2002-06-11, Nathan Neulinger <nneul@umr.edu> wrote:
> 
> > Is there any straightforward way of disabling the buttons on the CD and
> > locking all the time? I'm not averse to an ugly hack to 2.4.18+ source
> > if necessary.
> 
> I'm not sure exactly what you mean.  If there is a CD in the drive and
> mounted, the eject button should be software-locked.  Do you mean that this
> does not happen for you?  ...As long as it does, a stupid workaround would
> be "leave a CD in the drive mounted all the time".

-- 
Austin Gonyou <austin@digitalroadkill.net>
