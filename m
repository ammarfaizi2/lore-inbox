Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbTCMO6Z>; Thu, 13 Mar 2003 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbTCMO6Z>; Thu, 13 Mar 2003 09:58:25 -0500
Received: from [196.41.29.142] ([196.41.29.142]:17649 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S262414AbTCMO6W>; Thu, 13 Mar 2003 09:58:22 -0500
Subject: Re: Linux BUG: Memory Leak
From: Martin Schlemmer <azarah@gentoo.org>
To: James Stevenson <james@stev.org>
Cc: pd dd <parviz_kernel@yahoo.com>, "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
In-Reply-To: <01f901c2e96c$98b1e3d0$0cfea8c0@ezdsp.com>
References: <20030313091315.14044.qmail@web20504.mail.yahoo.com>
	 <01f901c2e96c$98b1e3d0$0cfea8c0@ezdsp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047567997.3504.80.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 13 Mar 2003 17:06:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 16:26, James Stevenson wrote:
> > With all due respect to all the great programmers and
> > minds in this mailing list. I could not read this and
> > not reply to this guy:
> >
> > Maybe you should take your games and movies to windows
> > and leave linux for more serious stuff. That'll fix
> > your memory leak.
> 
> correct me if i am wrong here but i know alot of students
> who use linux todo serious stuff and get really pissed off have to
> reboot into windows to play games because they dont work
> under windows and for various other things that also cause
> problems in linux. Actually quite alot of them end up
> dumping linux because any of the serious games wont work on there
> system because they would have to tear much of it apart toget
> them to work.
> 
> this isnt a serious problem then ?
> 

Ok, I do agree that when doing support for something like Linux
where most of your free time are spent at no charge, the way
help is asked, do make a difference.  However, we should try to
refrain from chasing people away when they do approach things with
a slight offensive attitude ....

Anyhow, as for your problem James, I did experience similar issues
in the past.  It was basically related to a gtk+ theme engine that
leaked memory like hell.  Try to change gtk+/kde/whatever themes.
Also maybe try to update your XFree86 if Slackware do have later
revisions out, as I really wont rule X out of being totally free
of major memory leaks (No offense toward xfree.org, you guys are
doing a great job =).  On the other hand ... XFree86 4.3.0 is out,
so you might try to compile that by hand just as a test.

Then, do not rule out the nvidia drivers for being totally bug free.
The version before 4191 had some serious page_alloc.c bugs, which
should partly be fixed by 4191.  It does still have issues though
if you are using rmap.  You can get patches for it here:

  http://www.minion.de/nvidia/

Also, I think there are another patch somewhere to fix one or other
problem, but cannot find it now.

Then kernel .... Did you try earlier versions to verify your suspicion ?
Or if the same thing with earlier kernel, maybe try it with 2.5.64 ?
Patches to get it working with 2.5 can be found above.

I am running a Geforce3 Ti5 here, and UT2003, UT, Quake3, etc are
working just fine.  Same thing for 2.4.19 (before I switched to
2.5 kernel) ... meaning if you have the same issues with 2.4.19,
then it is very possible that it is something else at fault.  Yes,
this is not clear cut, but ....


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

