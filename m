Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbSIXWAv>; Tue, 24 Sep 2002 18:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSIXWAv>; Tue, 24 Sep 2002 18:00:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:11534 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261824AbSIXWAu>; Tue, 24 Sep 2002 18:00:50 -0400
Date: Wed, 25 Sep 2002 00:06:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Message-ID: <20020924220607.GD1496@atrey.karlin.mff.cuni.cz>
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz> <3D90D388.746D0C0D@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90D388.746D0C0D@opersys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This is a patch for adding the Adeos nanokernel to the Linux kernel as
> > > described earlier:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=102309348817485&w=2
> > 
> > Maybe adding Docs/adeos.txt is good idea... (sorry can't access web
> > right now) --
> 
> Right, we'll do that.
> 
> > so this is aimed at being free rtlinux replacement?
> 
> I'm not sure "replacement" is the appropriate description for this.
> The scheme used by rtlinux and rtai is a master-slave scheme where
> Linux is a slave to the rt executive. Adeos makes the entire scheme
> obsolete by making all the OSes running on the same hardware clients
> of the same nanokernel, regardless of whether the client OSes provide
> hard RT or not. None of these OSes need to have a "other OS" task,
> as rtlinux and rtai clearly do. Rather, when an OS is done using
> the machine, it tells Adeos that it's done and Adeos returns control
> to whichever other OS is next in the interrupt pipeline.

Are you actually able to use Adeos for something reasonable? You can't
run two copies of linux, because they would fight over memory; right?

Do you have something that can run alongside linux?
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
