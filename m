Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbTDKLo3 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 07:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTDKLo3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 07:44:29 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:65287 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264335AbTDKLo1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 07:44:27 -0400
Message-ID: <3E96ADB0.2080206@aitel.hist.no>
Date: Fri, 11 Apr 2003 13:57:36 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net> <3E94A1B4.6020602@si.rr.com> <Pine.LNX.4.53.0304092126130.992@chaos> <1050001030.12494.1.camel@dhcp22.swansea.linux.org.uk> <shsvfxm157p.fsf@charged.uio.no> <Pine.LNX.4.53.0304101638010.4978@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> But sometimes, just for kicks, I boot Ultrix (Unix) on the second
> drive. It takes only 4 minutes and doesn't waste time with all
> those "progress" messages. Now, Linux has already gotten to
> be like VMS with all those "progress" messages displayed while
> it's booting. It's really quite annoying,
There are several ways to get rid of them - I lost all
once when using a unsupported framebuffer.  No messages
at all until X came up.

> and it scares the
> hell out of users that are graduating from Windows.

Couldn't care less about the scaring part.  Linux is different,
otherwise why try it?  So they better expect some differences
and get used to them.  Scared - bah!

Much user interface work can be done on easing the transition, but
this is not one of those cases.  Because people just don't
need to deal with those messages unless there's a crash.  And then
they get time enough to read the frozen display, and
the details _will_ be useful.

> Anything
> that further legitimizes those progress messages (like translation)
> should never be implemented.
> 
> When somebody is writing a driver, if they have any experience,
> they write debugging messages in their native language. But, once
> the driver is written, these debugging messages should be removed
> or #defined out. A properly functioning driver should never complain
> about anything. 

It shouldn't complain, but I see no problem with the driver
saying "ok, found 3 scsi adapers and 8 disks"  This is
particularly useful if I expected it to find all 4 adapters.
The driver saw no problem but I still did.

> It shouldn't do anything like you see when you
> execute `dmesg`.

Get used to it.  Linux scroll some pages of text at bootup - so what?
Of course you _can_ configure it away if you want to, or get your
linux from a distributor that do.  It is more interesting than
watching a blank screen and wondering "what takes so much time?"
With linux I see that - it lets me optimize, for example by
dropping support for nonexisting hardware that have long
probe timeouts.  This sort of thing isn't for "everybody",
but even windows people enjoy optimizing their machines a bit now and then.

Helge Hafting

