Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSADN3L>; Fri, 4 Jan 2002 08:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288525AbSADN3C>; Fri, 4 Jan 2002 08:29:02 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:50076 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S288582AbSADN2v>;
	Fri, 4 Jan 2002 08:28:51 -0500
Date: Fri, 4 Jan 2002 15:27:03 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: <lk@behemoth.ts.ray.fi>
To: Marco Ermini <markoer@markoer.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [OT] Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <20020103232614.26f2f5af.markoer@markoer.org>
Message-ID: <Pine.LNX.4.33.0201041522030.1702-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...]
> > I'm having the exact same problems on my ThinkPad 390X. Sometimes it
> > freezes several times a day with the exact same symptoms. RedHat 6.2
> > worked fine on this laptop. The problems started with 7.1 which uses 
> > XFree86 4.0, and it didn't get better with 7.2 (XFree86 4.1).
> > What makes it even worse is that after a warm reboot, the screen and 
> > keyboard locks up again as soon as gdm gets started (Numlock doesn't work 
> > etc.). So I always have to turn off the power to get the laptop working 
> > again.
> 
> A similar things happened to me. I have a Toshiba Satellite 4080 XCDT, and
> switching from XFree to console and back to XFree becomed impossibile with the
> upgrade to Redhat 7.x and XFree 4. The problem is that the apm script use to
> switch to console mode when I suspend (es. closing the laptop) and when it
> resumes it tries to switch to XFree again, but this messes the screen. I am
> still able to come back to console and killall X, but of course I'll lose my
> current not saved works under X.
> 
> Under XFree 3 I could switch from X to console and back without problems -
> anyway, after a couple of switches my laptop used to hang. I think X writes to
> the uncorrect memory regions causing my laptop to hang.

This really is offtopic, because the above symptoms are caused solely by 
XFree 4.1. The was discussion about this in XFree mailing lists.

A quick fix is to get a newer RedHat Rawhide XFree86 rpm (atleast
4.1.0-8 and later have that bug fixed) or better yet get a newer 
tarball of X from xfree86.org 

yers,
 another member of "Linux on a Toshiba Satellite 4080xcdt (TM)" :)

-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */

