Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUBLRK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUBLRK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:10:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:27317 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266523AbUBLRKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:10:19 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Michael Buesch <mbuesch@freenet.de>, Chris Stromsoe <cbs@cts.ucla.edu>
Subject: Re: lock up with 2.4.23
Date: Fri, 13 Feb 2004 01:19:58 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402111939370.5221@potato.cts.ucla.edu> <200402121634.32186.mbuesch@freenet.de>
In-Reply-To: <200402121634.32186.mbuesch@freenet.de>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402130119.58662.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 23:34, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thursday 12 February 2004 06:18, you wrote:
> > When the machine locked up, it was not pingable.  I connected via serial
> > console and used sysrq to sync and remount the disks readonly.  I also got
> > output from sysrq+t, sysrq+p, and sysrq+m.  Output is below.
> 
> I had a lockup on 2.4.24 today, too.
> The machine was not pingable (suddenly) and all network
> access failed (NFS, SSH).
> The box had an uptime of aproximately 20 days.
> 
> Machine is a pentium 1 75 Mhz with 48MB Ram.
> 
> The bad things are:
> - - I have no logs. They got lost when I reset the machine.
> - - The kernel was tainted with the fritzcard dsl driver.
>   But exact the same driver had uptimes of over 30 days on
>   this machine several times in the past.
> - - The machine has no peripheral hardware, so I was not
>   able to test sysrq, catch dmesg or something like that.
> 
> I know, that this mail is not very helpfull, but maybe
> better than sending no mail at all. :)
> 

You say your drivers are not that bad, OK, the kernel is not 
that bad too.

Now, please consider that this mainboard is about 10 years old.
How old is the PSU?

Consider whether the ambient temperature was higher than average
at time of lockup.

Please check:

1) CPU heatsink contaminated
2) CPU fan bad
3) PSU fan bad or contaminated (also PSU slots/fins)
4) Power supply instabel due to capacitors drying out
5) Mainboard CPU voltage instable due to capacitors drying out
6) Bad contacts at memory modules
7) Coroded PSU or other connectors

... Just some of the things I have encountered

Bottom line: its HW!

Your mail is helpful ;)

Michael


