Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbTC0C0J>; Wed, 26 Mar 2003 21:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbTC0C0J>; Wed, 26 Mar 2003 21:26:09 -0500
Received: from [66.186.193.1] ([66.186.193.1]:38411 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262785AbTC0C0I>; Wed, 26 Mar 2003 21:26:08 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 21:40:20(EST) on March 26, 2003
X-HELO-From: [10.134.0.78]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: sisfb: two more little problems
From: Torrey Hoffman <thoffman@arnor.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303270021000.25001-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303270021000.25001-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048732634.1551.7.camel@rohan.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2003 18:37:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 16:22, James Simmons wrote:
> > Besides the problems with mode switching with fbcon, I have two other
> > problems with sisfb:
> > 
> > 1. My gpm mouse cursor on the framebuffer console is a cyan rectangle
> > with a bright orange "G" in it.  Actually the G has a "^" accent over
> > it.  That's just when it's over a blank spot.  When I move it over other
> > characters, the character in the pointer changes.  However, it does work
> > for selecting text.
> 
> Try my latest patch. It should fix this. 
> 

Well, not quite.  The problem is still there.  I have checked it a
little more closely though, and noticed that it isn't always there. 
Some virtual consoles have the problem and some don't.  It seems like
before I log in on a console, there's no problem.  And sometimes even
after logging in it is OK, but usually after I log in the green and
orange framebuffer mousepointer starts.

This is Red Hat 8.0, by the way.  I think it does something to the
console when I log in, the screen usually blanks for a second after I
enter the login password and before the bash prompt appears.

> > video=sisfb:1024x768-24@75
> > 
> > and neither one works.  What is the expected command line?
> 
> It is video=sisfb:...
> 
> Hm. It should work. 

I found the sisfb web page and it is:
video=sisfb:mode:1024x768x24

and that works, but only at 60 HZ.  I haven't tried putting a "@75" on
the end yet...

Thanks again!

-- 
Torrey Hoffman <thoffman@arnor.net>

