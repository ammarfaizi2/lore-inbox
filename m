Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDKRq7 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTDKRq7 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:46:59 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:37841 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261300AbTDKRqy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:46:54 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2003 10:55:31 -0700 (PDT)
Subject: Re: kernel support for non-english user messages
In-Reply-To: <3E96ADB0.2080206@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0304111050340.8422-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Helge Hafting wrote:

> Richard B. Johnson wrote:
> >
> > When somebody is writing a driver, if they have any experience,
> > they write debugging messages in their native language. But, once
> > the driver is written, these debugging messages should be removed
> > or #defined out. A properly functioning driver should never complain
> > about anything.
>
> It shouldn't complain, but I see no problem with the driver
> saying "ok, found 3 scsi adapers and 8 disks"  This is
> particularly useful if I expected it to find all 4 adapters.
> The driver saw no problem but I still did.
>

the problem is one of noise, while it is sometimes useful to see these
messages (back when I was a PC tech working on windows systems I kept a
set of slackware disks handy to boot from and see what hardware was really
installed in the machines before hunting for the windows drivers) we are
also getting to a point where so many things are flashing by on the screen
that it's very hard to see them (especially with todays nice fast
machines).

it's like network Intrusion Detection systems, a lot of people install
them and gain no value from them becouse they send out so many alerts that
they get ignored.

I definantly don't want the verbose mode to go away, but it may be time to
make the default be the quiet mode that only prints actual errors instead
of the current verbosity.

David Lang
