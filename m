Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUISJ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUISJ4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 05:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269203AbUISJ4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 05:56:47 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:33703 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269093AbUISJz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 05:55:56 -0400
Message-ID: <20040919095555.36906.qmail@web11903.mail.yahoo.com>
Date: Sun, 19 Sep 2004 02:55:54 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Jon Smirl <jonsmirl@gmail.com>, Keith Packard <keithp@keithp.com>
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091817545b3d2675@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jon Smirl <jonsmirl@gmail.com> wrote:

> Isn't there an enviroment variable that tells what device is the
> console for the session? How do you tell what serial port you're on
> when multiple people are logged in on serial lines?
> 
The FDs 0, 1 and posibly 2 will be the console.  Per posix?  There should
be no other ties to the current console.  Right?

I think this is totaly a userspace question or do we need to find out the
procs console in an ioctl?

> 
> On Sat, 18 Sep 2004 16:33:54 -0700, Keith Packard <keithp@keithp.com>
> wrote:
> > 
> > Around 18 o'clock on Sep 18, Jon Smirl wrote:
> > 
> > > The sysfs scheme has the advantage that there is no special user
> > > command required. You just use echo or cp to set the mode.
> > 
> > But it makes it difficult to associate the sysfs entry with the
> particular
> > session.  Seems like permitting multiple opens of /dev/fb0 with mode
> > setting done on that file pointer will be easier to keep straight
> > 
> > 
> > 
> > 
> 
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
