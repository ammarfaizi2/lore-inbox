Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbTI3IJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTI3IJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:09:46 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51461 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261205AbTI3IJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:09:41 -0400
Message-ID: <3F793C57.10403@aitel.hist.no>
Date: Tue, 30 Sep 2003 10:18:31 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: kartikey bhatt <kartik_me@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: [OT ]Re: Can't X be elemenated?
References: <LAW11-F18b4SaFMwr9y00007564@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kartikey bhatt wrote:
> Hi Linus.
> 
> I read your reply to a person worried about the future of linux. It was a
> satisfactory reply; I hope to get a satisfactory reply for this one also.
> 
> Can't X be elemenated?

Trivially.  X is a stand-alone app, this is as easy as not running
it.  (Or not installing it, if you don't want to spend the disk space.)
That means no GUI apps, but there are plenty of programs that
don't need the GUI.

> I mean to say kernel level support for graphics device drivers and special
> routines for accessing it directly; rest will be done by user space widget
> libraries (or say a kernel space light widget library which can be 
> customized
> by user space libraries).
> 
Then you move the "bloat" to the kernel, where it does more
damage than were it is now.  No real win, but definitely loss.

> Why am I asking this?
> 
> 1st. X is bloat. Though it's good for server environments. For desktop pcs
> it's too heavy. On my machine (PIII500 with 128MB RAM) I have to choose 
> from
> either to run X or compile 2.6.0-test6.

You're wrong.  X is lightweight.  I remember running it on a 386
with 8M RAM - much faster than windows 3.1 of that time.

I guess you're merely running some very heavy apps.
1. Get a lightweight window manager.  There are many
    to chooce from, such as icewm, fwwm, twm, openbox,...
    Don't run heavy stuff like enlightenment.  It looks good,
    but it is meant for bigger machines than yours.
2. Avoid gnome and kde whenever possible.  These two wants more
    than 128M.  And possibly more cpu too.
3. Make sure you have a x server that uses acceleration
    (Check the x server log) and make sure you aren't
    running an IDE disk in pio mode and without
    interrupt unmasking. (take a look at hdparm)

You should now have a lean fast system compared to windows.

> 
> 2nd. It's process based client/server architecture is a bottleneck. It's 
> not
> as interactive as is supposed to be.
Likely some other problem, see above.


> 3rd. Most important. I can't impress or convince my window(crash)(TM) user
> friends, relatives (who saw X running on my pc) to use Linux.
> 
Can't do that with an ill-configured system.  Oh, and make sure
the comparison is sensible - are they running windows on
128M 500MHz machines too?

> 4th. I want to see desktop being ruled by Linux.
> 
Linux is good enough for that already.  Companies are changing
to linux on the desktops as a cost-cutting measure - no
licences and slightly lower demands for hardware. And there
is enough apps too!  (Not as many as for windows, but _enough_,
more is coming.)

Now, "good enough" is no reason to stop getting better.  But
integrating X into the kernel is not the way to go, particularly because
it don't buy us much.

X not in the kernel means a fault in X don't take out the kernel
(crashing the machine) either.  Seems you like that aspect of
it. Also, X supports networking as is.  Try running apps
remotely with windows - you'll have to buy third party
software first and it isn't as good.
I routinely log in to my office pc from home, and run GUI apps
over and ADSL line.  It just works.

> "Present" is in our hands; we are ruling servers.
> You said "Linux, world domination fast".
> If my wish is fulfilled, I am sure, one day, You (Mr. Linus) and I will
> be saying "Linux, world domination completed".
:-)

Helge Hafting


