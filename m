Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUAZPoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbUAZPlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:41:37 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:22757 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265295AbUAZPlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:41:12 -0500
Date: Mon, 26 Jan 2004 07:41:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: problems connecting to kernel.bkbits.net
Message-ID: <20040126154111.GB18032@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric forwarded me this mail (thanks).

The BK->CVS gateway is still going strong but the CVS server part of it has
been shut down because of security problems.  Nobody wants to run it because
of the security problems that CVS has.  If someone wants to do that they 
can mirror it from kernel.org, it's there under /pub/scm/linux/kernel/bkcvs
and if you grab that you can start up a CVS server.

----- Forwarded message from Stas Sergeev <stsp@aknet.ru> -----

From: Stas Sergeev <stsp@aknet.ru>
To: linux-kernel@vger.kernel.org
Subject: problems connecting to kernel.bkbits.net
Date:	Sun, 25 Jan 2004 20:11:35 +0300


Hello.

I used a BK->CVS gateway on kernel.bkbits.net
for some time, but it is already several
month that I can't connect to it any more.
Is it still alive?

Here is what I have:

$ cvs update
cvs [update aborted]: connect to kernel.bkbits.net(192.132.92.14):2401 
failed: No route to host

$ traceroute kernel.bkbits.net
 1  gate (192.168.3.1)  5.823 ms  16.544 ms  8.973 ms
 2  RINNet-MSU.iitp.ru (194.220.14.45)  12.531 ms  143.000 ms  69.300 ms
 3  RINNet-IITP.iitp.ru (194.220.14.129)  134.844 ms  212.712 ms 
190.928 ms
[.....]
20  svl-edge-09.inet.qwest.net (205.171.14.98)  312.245 ms *  204.768 ms
21  63.150.59.90 (63.150.59.90)  268.390 ms  217.756 ms  218.520 ms
22  216.240.36.206 (216.240.36.206)  218.669 ms  248.692 ms  218.659 ms
23  kernel.bkbits.net (192.132.92.14)  214.393 ms !<10>  243.426 ms 
!<10> *

$ ping kernel.bkbits.net
PING kernel.bkbits.net (192.132.92.14) from 192.168.3.28 : 56(84) 
bytes of data.64 bytes from kernel.bkbits.net (192.132.92.14): 
icmp_seq=0 ttl=44 time=239.295 msec
64 bytes from kernel.bkbits.net (192.132.92.14): icmp_seq=1 ttl=44 
time=230.619 msec

--- kernel.bkbits.net ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/mdev = 230.619/234.957/239.295/4.338 ms


Now I am lost. ping is fine, but traceroute
shows code 10, which is "Host prohibited".
Any ideas what can that be?
I have googled a lot, but I have found
nothing that looks even nearly similar to the
problem I am having.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
