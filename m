Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTIRD0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 23:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIRD0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 23:26:09 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:48770
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262942AbTIRD0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 23:26:06 -0400
Date: Wed, 17 Sep 2003 23:26:04 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Michael Frank <mhf@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard problems: magic key + h stuck, and keyboard errors,stuck
 keys with 2.6.0-test5-bk3
In-Reply-To: <200309171845.13790.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0309172323530.22608-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Issue 1: magic key + h noise

I have determined that LILO on the remote box is feeding noise back to the
other machine while it's booted. When I commented the serial port in
inittab and init q'd. Shut the other machine down and brought it up. I saw
no such noise spewed out.

This is not a kernel issue.

As for the keyboard sticky issue other users are reporting this as well.

Shawn S.
On Wed, 17 Sep 2003, Michael Frank wrote:

> On powerup the ports may see breaks.
>
> Disable magic sysrq on the ports by which both machines connect ;)
>
> So, either use seperate ports or turn of magic sysrq - can alos do
> in proc fs.
>
> Regards
> Michael
>
> On Monday 15 September 2003 14:12, Shawn Starr wrote:
> > I have two systems, When I turn the system next to me on the machine thats
> > currently powered on spews out this each time, why is the magic key
> > (alt+sysrq h) being dumped?
> >
> > Also, what is the best way to debug a kernel over serial when the system
> > on the other end is completely locked?
>
> KGDB
>
> Alternatives KDB via keyboard or KGDB via ethernet
>
> >
> > The other issue is:
>
> Also interface problem but sorry, don't know how to fix
>
> Regards
> Michael
>
>
>

