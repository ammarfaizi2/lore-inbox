Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136610AbREALTZ>; Tue, 1 May 2001 07:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136613AbREALTQ>; Tue, 1 May 2001 07:19:16 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136610AbREALTF>;
	Tue, 1 May 2001 07:19:05 -0400
Message-ID: <20010430104231.C3294@bug.ucw.cz>
Date: Mon, 30 Apr 2001 10:42:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <9cg7t7$gbt$1@cesium.transmeta.com>; from H. Peter Anvin on Sat, Apr 28, 2001 at 10:13:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In x86-64 there are special vsyscalls btw to solve this problem that export
> > > a lockless kernel gettimeofday()
> > 
> > Whatever happened to that hack that was discussed a year or two ago?
> > The one where (also on IA32) a magic page was set up by the kernel
> > containing code for fast system calls, and the kernel would write
> > calibation information to that magic page. The code written there
> > would use the TSC in conjunction with that calibration data.
> > 
> > There was much discussion about this idea, even Linus was keen on
> > it. But IIRC, nothing ever happened.
> > 
> 
> We discussed this at the Summit, not a year or two ago.  x86-64 has
> it, and it wouldn't be too bad to do in i386... just noone did.

Just wait what kind of problems it is able to bring on i386.

								Pavel
PS: Hmm, how do you do timewarp for just one userland appliation with
this installed?

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
