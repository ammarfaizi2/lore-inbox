Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135906AbREDIHw>; Fri, 4 May 2001 04:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135912AbREDIHc>; Fri, 4 May 2001 04:07:32 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135906AbREDIH0>;
	Fri, 4 May 2001 04:07:26 -0400
Message-ID: <20010504100632.B13243@bug.ucw.cz>
Date: Fri, 4 May 2001 10:06:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Gregory Maxwell <greg@linuxpower.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010503210904.B9715@bug.ucw.cz> <E14vPZF-00069W-00@the-village.bc.nu> <20010503164112.A26907@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010503164112.A26907@xi.linuxpower.cx>; from Gregory Maxwell on Thu, May 03, 2001 at 04:41:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That means that for fooling closed-source statically-linked binary,
> > 
> > If they are using glibc then you have the right to the object to link
> > with the library and the library source under the LGPL. I dont know of any
> > app using its own C lib
> 
> Some don't use any libc at all, some just don't use it for the time call
> that were talking about substituting.
> 
> Lying about the time is a hack, pure and simple. It will still be possible
> with magic pages. The fact that it will require more kernel hacking to
> accomplish it is irrelevant.

No. You are breaking self-virtualization here. That is not irrelevant.

It used to require no kernel support before. Now it will require
kernel support. That's step back. (Think uml).

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
