Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJOD0B>; Mon, 14 Oct 2002 23:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJOD0B>; Mon, 14 Oct 2002 23:26:01 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:52934 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262325AbSJOD0A>; Mon, 14 Oct 2002 23:26:00 -0400
Date: Mon, 14 Oct 2002 23:31:47 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 loses keyboard and mouse when starting X
Message-ID: <20021015033147.GA1695@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021012094833.GA1622@Master.Wizards> <20021014233035.A20926@balu.sch.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014233035.A20926@balu.sch.bme.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:30:35PM +0200, Pozsar Balazs wrote:
> 
> On Sat, Oct 12, 2002 at 05:48:33AM -0400, Murray J. Root wrote:
> > Not sure what info is needed here - there are no error messages
> > anywhere.
> > 
> > ASUS P4S533 (SiS645DX chipset)
> > P4 2Ghz cpu
> > 1G PC2700 RAM
> > SBLive! value (using ALSA driver)
> > NVidia GeForce2 GTS (using XFree86 nv driver)
> > PS/2 Keyboard & mouse
> > 
> > Mandrake 9.0
> > XFree86 4.2.1
> > 
> > Boot to console & login with no problem.
> > Run console apps with no problem.
> > run startx and X appears to start normally, but keyboard and mouse
> > are dead.
> > Only thing in .xinitrc is
> >   exec /usr/X11R6/bin/startfluxbox
> > 
> > No new messages in any log files.
> > 
> > Happens with all 2.5.4x including -ac
> 
> Do you have a PS/2 mouse? Try starting X without mouse, to see if it is 
> the problem.
> 
PS/2 mouse.
X won't start without mouse specified.
Disabling Load "glx" and making sure gpm wasn't running it switched to X
with the keyboard still functional, but not reliably. Sometimes it worked,
sometimes it didn't.
Having gpm loaded, it never worked - keyboard and mouse dead.
Having Load "glx" in /etc/X11/XF86Config-4, it never worked.

2.4.x works fine in X

One thing I just noticed - gpm doesn't supply a mouse pointer in console 
in 2.5.x. It does in 2.4.x.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

