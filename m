Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTB0ISA>; Thu, 27 Feb 2003 03:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTB0IR7>; Thu, 27 Feb 2003 03:17:59 -0500
Received: from daimi.au.dk ([130.225.16.1]:56236 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261908AbTB0IR6>;
	Thu, 27 Feb 2003 03:17:58 -0500
Message-ID: <3E5DCC16.FD6BAD62@daimi.au.dk>
Date: Thu, 27 Feb 2003 09:28:06 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Wenninger <jowenn@jowenn.at>
CC: Miles Bader <miles@gnu.org>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
		<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> 
		<3E5DB2CA.32539D41@daimi.au.dk> <1046329422.1404.10.camel@jowennmobile>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Wenninger wrote:
> 
> Hi
> 
> Am Don, 2003-02-27 um 07.40 schrieb Kasper Dupont:
> > Miles Bader wrote:
> > >
> > > Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > > I don't think you can put all the information from /etc/mtab
> > > > into /proc/mounts without breaking compatibility.
> > >
> 
> For KDE 3.1 I've written a mount watcher, which checks the modification
> time of the /etc/mtab to recognize mount/unmount activity, which broke
> for linux from scratch( for now, they have updated there install
> instructions), because they linked to /proc/mounts, which doesn't seem
> to support mtime.

It seems the mtime of anything under /proc simply gives the current time.
Would that be hard to change? And would anything break if /proc/mounts
gave the time of the last change? It shouldn't be a major problem to
record the time of the last sucessfull mount, remount, or unmount.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
