Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDTVjX>; Fri, 20 Apr 2001 17:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDTVjN>; Fri, 20 Apr 2001 17:39:13 -0400
Received: from thepigsty.demon.co.uk ([158.152.99.38]:36314 "EHLO
	mad.pigsty.org.uk") by vger.kernel.org with ESMTP
	id <S131988AbRDTVi6>; Fri, 20 Apr 2001 17:38:58 -0400
To: <lkern@mail.co.gilchrist.fl.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic Linux 2.4.3 RH7
In-Reply-To: <Pine.LNX.4.21.0104201647250.1287-100000@proxy.co.gilchrist.fl.us>
From: Tim Haynes <piglet@stirfried.vegetable.org.uk>
In-Reply-To: <lkern@mail.co.gilchrist.fl.us>'s message of "Fri, 20 Apr 2001 17:01:05 -0400 (EDT)"
Reply-To: Tim Haynes <piglet@stirfried.vegetable.org.uk>
Date: 20 Apr 2001 22:37:53 +0100
Message-ID: <877l0ffe1a.fsf@straw.pigsty.org.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<lkern@mail.co.gilchrist.fl.us> writes:

> Machine has been locking up between 0-3 times a day sporadically. Nothing
> predictable about it. Hadn't locked up for 3 days, and locked 3x today,
> the last 2 times within 20 minutes of each other. Had run stable with
> 2.2.18, and was running fairly stable on 2.4.3 up until about last week.
> (might be coincidence, or not, but seems to happen when I am on IRC --
> DOS?, nothing in log files or firewall logs however)
> 
> Machine info:
> 
> RedHat 7, Intel Celeron 450, 256Meg ECC PC100 DRAM, 1 15G IDE (/usr,
> /tmp, /home, /var, swap ), 1 2G SCSI (/, /boot, swap) HDD, 2 identical
> tulip chipset eth cards.
[snip]
> 
> Mismatch in TCPACCEPT IN=ETH0 OUT= MAC= 00:00:e8:24:53
[snip]
> (stack information skipped, if you need it let me know and I will write it
> all down the next time)
> 
> Process: swapper (pid0, stack page c02dl000)
[snip]

Take your pick from one or more of the following:
    a) dodgy RAM - less likely if a different set of RAM has also had
       the problem;
    b) a faulty network card - a tulip (Netgear FA310TX) reliably caused me
       a hang ~6 months ago, so there is a precedent;
    c) overheating - see if, left to its own devices, the hangs become
       more frequent the longer the box is left on; also implement
       lm_sensors and keep an eye on the CPU temperature if possible;
    d) RH7 alert: did you use kgcc to build the kernel?
    e) Something totally else :8)

HTH,

~Tim
-- 
   10:32pm  up 3 days, 46 min, 10 users,  load average: 0.18, 0.10, 0.08
piglet@stirfried.vegetable.org.uk |Clouds cross the black moonlight,
http://piglet.is.dreaming.org     |Rushing on down to the sound 
                                  |of a turning world           
