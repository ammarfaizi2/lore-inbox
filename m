Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTDJUjX (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbTDJUjX (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:39:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12679 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264162AbTDJUjW (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:39:22 -0400
Date: Thu, 10 Apr 2003 16:53:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frank Davis <fdavis@si.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
In-Reply-To: <shsvfxm157p.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.53.0304101638010.4978@chaos>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org>
 <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net>
 <3E94A1B4.6020602@si.rr.com> <Pine.LNX.4.53.0304092126130.992@chaos>
 <1050001030.12494.1.camel@dhcp22.swansea.linux.org.uk> <shsvfxm157p.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003, Trond Myklebust wrote:

> >>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
>      > VMS is alive and well, even though Compaq tried to kill
>      > it. There is a lot of anti-VMS stuff in the Unix world mostly
>      > coming from the _horrible_ command line and other bad early
>      > memories. There is also a hell of a lot of really cool stuff
>      > under that command line we could and should learn from.
>
> The day I wake up and see one of my processes in the "RWAST" state is
> the day I move to a BSD clone 8-)
>
> Which features in particular were you thinking would be worth porting?
>
> Cheers,
>  Trond
>

Once a year I get up enough nerve to boot my VAXen at home. One
is a uVAX-II which even has SCSI with some DEC snail disks.
The uVAX-II takes about 45 to 50 minutes to boot and it's really
quite amazing to watch it do all that difficult stuff, with all
its intermediate progress messages being written to the screen
when it's booting VMS.

But sometimes, just for kicks, I boot Ultrix (Unix) on the second
drive. It takes only 4 minutes and doesn't waste time with all
those "progress" messages. Now, Linux has already gotten to
be like VMS with all those "progress" messages displayed while
it's booting. It's really quite annoying, and it scares the
hell out of users that are graduating from Windows. Anything
that further legitimizes those progress messages (like translation)
should never be implemented.

When somebody is writing a driver, if they have any experience,
they write debugging messages in their native language. But, once
the driver is written, these debugging messages should be removed
or #defined out. A properly functioning driver should never complain
about anything. It shouldn't do anything like you see when you
execute `dmesg`. The only time you should see information is
if there's trouble. And trouble with software should be fixed
immediately so you never have to encounter messages because software
didn't work. So, you are left will hardware messages like your
SCSI disk didn't come on-line, or you are out of disk-space.
For so few messages, you don't need translation, certainly not
in the kernel. Just Babel-fish it and away you go.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

