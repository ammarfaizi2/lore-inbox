Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTBDTjB>; Tue, 4 Feb 2003 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBDTjB>; Tue, 4 Feb 2003 14:39:01 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:21684 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S267431AbTBDTjA>; Tue, 4 Feb 2003 14:39:00 -0500
Date: Tue, 4 Feb 2003 11:48:29 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: Nohez <nohez@cmie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timer interrupts on HP machines
In-Reply-To: <Pine.LNX.4.33.0302041004300.32614-100000@venus.cmie.ernet.in>
Message-ID: <Pine.LNX.4.44.0302041146540.13053-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, it's definitely the HP hardware, since we also only see this problem 
on the NetServers. I haven't worked with the LH series, though, just the 
LT series. We've brought up issues like this with their support 
organization, with the inevitable response "unable to reproduce problem" 
and a closed ticket. We've given up since they ditched the NetServer line 
in favor of the Proliants anyways.

Good Luck.

-Matt

On Tue, 4 Feb 2003, Nohez wrote:

> 
> Hi Matt,
> 
> We have the MP spec set to v1.4 for more than a year and the systems have
> been unplugged for more than 1 hr for system maintenance many times. The
> BIOS firmware is 4.06.43. We suspect the kernel triggering a hardware bug
> as we see this only on HP Netservers. We have other unbranded Intel
> SMP machines running the same kernel, distro & same services without this
> problem.
> 
> Nohez.
> 
> On Mon, 3 Feb 2003, Matt C wrote:
> 
> > Hi Nohez:
> >
> > That's interesting. We've traced almost all of the times when this happens
> > back to an incorrect MP spec. I know it sounds goofy, but have you tried
> > unplugging AC power from the machine for ~5 minutes or so? We've seen that
> > make a difference in the Netservers. Also make sure you're up-to-date with
> > the firmware (latest is 4.06.43 or so?). Outside of that, I don't have any
> > other suggestions besides calling HP and having them replace the system
> > board.
> >
> 
> 

