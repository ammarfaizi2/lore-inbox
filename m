Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279264AbRKAQbb>; Thu, 1 Nov 2001 11:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279271AbRKAQbV>; Thu, 1 Nov 2001 11:31:21 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:27943 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279264AbRKAQbQ>; Thu, 1 Nov 2001 11:31:16 -0500
Date: Thu, 1 Nov 2001 11:27:03 -0500 (EST)
From: Peter Jones <pjones@redhat.com>
X-X-Sender: <pjones@lacrosse.corp.redhat.com>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
cc: Paul Mackerras <paulus@samba.org>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <Pine.LNX.4.33.0111011621070.2281-100000@tahallah.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0111011126200.9216-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Alex Buell wrote:

> On Thu, 1 Nov 2001, Peter Jones wrote:
> 
> > > Ah, is that what it does. OK, I'll carefully suggest to the authors of ESD
> > > (preferably with a blunt trauma instrument) using AFMT_S16_NE. Thanks.
> 
> > It should probably be mentioned that you're using a really old version
> > of ESD, and that they've at least made it so that you'll get the right
> > one for any BE machine.  NE is still the better answer though -- now
> > their configure script figures out BE/LE, and it'll build wrong if
> > you're crosscompiling.
> 
> But this version I'm using is esound-2.2.8, which came from www.gnome.org!
> I suppose I'll have to grab it from their CVS server.

Oh, I'm sorry.  You said "2.8" last time and I assumed you meant 0.2.8.  
How interesting...

In any event, the answer is "use _NE", I think.

-- 
        Peter

"We all enter this world in the same way: naked; screaming; soaked in
blood.  But if you live your life right, that kind of thing doesn't have
to stop there."
		-- Dana Gould

