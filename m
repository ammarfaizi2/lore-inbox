Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRBTSTP>; Tue, 20 Feb 2001 13:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130046AbRBTSTF>; Tue, 20 Feb 2001 13:19:05 -0500
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:51464 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S129434AbRBTSSv>; Tue, 20 Feb 2001 13:18:51 -0500
From: Colonel <klink@clouddancer.com>
To: james@pcxperience.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A92AA23.9A0BAC43@pcxperience.com> (james@pcxperience.com)
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Reply-To: klink@clouddancer.com
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com>
Message-Id: <20010220181849.F1C68682B@mail.clouddancer.com>
Date: Tue, 20 Feb 2001 10:18:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Sender: james@pcxperience.com
   Date: Tue, 20 Feb 2001 11:32:19 -0600
   From: "James A. Pattie" <james@pcxperience.com>
   X-Accept-Language: en
   Content-Type: text/plain; charset=us-ascii

   Colonel wrote:

   > In clouddancer.list.kernel.owner, you wrote:
   > >
   > >I'm not subscribed to the kernel mailing list, so please cc any replies
   > >to me.
   > >
   > >I'm building a firewall on a P133 with 48 MB of memory using RH 7.0,
   > >latest updates, etc. and kernel 2.4.1.
   > >I've built a customized install of RH (~200MB)  which I untar onto the
   > >system after building my raid arrays, etc. via a Rescue CD which I
   > >created using Timo's Rescue CD project.  The booting kernel is
   > >2.4.1-ac10, no networking, raid compiled in but raid1 as a module
   >
   > Hmm, raid as a module was always a Bad Idea(tm) in the 2.2 "alpha"
   > raid (which was misnamed and is 2.4 raid).  I suggest you change that
   > and update, as I had no problems with 2.4.2-pre2/3, nor have any been
   > posted to the raid list.

   I just tried with 2.4.1-ac14, raid and raid1 compiled in and it did the
   same thing.  I'm going to try to compile reiserfs in (if I have enough room
   to still fit the kernel on the floppy with it's initial ramdisk, etc.) and
   see what that does.


Hmm.  reiserfs is probably OK as a module.  ac14 is 5 versions
'behind'.  I'd start looking for a distribution problem.
