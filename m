Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSDSSA4>; Fri, 19 Apr 2002 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSDSSAz>; Fri, 19 Apr 2002 14:00:55 -0400
Received: from waste.org ([209.173.204.2]:31438 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312704AbSDSSAz>;
	Fri, 19 Apr 2002 14:00:55 -0400
Date: Fri, 19 Apr 2002 13:00:44 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: "Dr. Death" <drd@homeworld.ath.cx>, <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <Pine.LNX.3.95.1020419100917.724A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0204191256180.8537-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Richard B. Johnson wrote:

> On Thu, 18 Apr 2002, Dr. Death wrote:
>
> > Problem:
> >
> > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a
> > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the
> > damaged part of the file !
> >
>
> So what do you suggest? You can see from the logs that the device
> is having difficulty  reading your damaged CD. You can do what
> Windows-95 does (ignore the errors and pretend everything is fine),
> or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> or you can try like hell to read the files like Linux does. What do you
> suggest?

The problem is not that reading the disk is slow, it's that it brings the
system to its knees. There are many valid scenarios where non-root users
should be able to put CDs in a machine and they shouldn't be able to DoS
it by doing so.

Fact is the SCSI layer's error handling has been on the list of things in
dire need of replacement for years and this is one of the many symptoms.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

