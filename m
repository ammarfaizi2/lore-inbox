Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264964AbTLFIZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTLFIZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:25:10 -0500
Received: from mxsf12.cluster1.charter.net ([209.225.28.212]:24585 "EHLO
	mxsf12.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264964AbTLFIZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:25:05 -0500
Date: Sat, 6 Dec 2003 03:23:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Message-ID: <20031206082312.GA1730@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1070672114.2759.8.camel@big.pomac.com> <1070675560.4117.9.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070675560.4117.9.camel@athlonxp.bradney.info>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm-nf2 i686
X-Uptime: 03:06:49 up 21 min,  6 users,  load average: 3.40, 3.10, 2.06
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Sat, Dec 06, 2003 at 02:52:40AM +0100, Craig Bradney wrote:
> Ok.. I decided I would try the patch out.. here are the results:
> 
[snip]

I tried it out too since doing some greps after 3 days uptime crashed
it again.  Guess I am not so lucky.  So far so good with the new
patch, timer is using apic and no crashes yet, after 30 minutes of 
grep's and hdparms.  Tried booting with nmi_watchdog=1 and got this:

...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#0: NMI appears to be stuck!

Going to retry with nmi_watchdog=2 and see if that works.

> 
> Im not getting any NMI counts.. should I use nmi-watchdog=1?
> 
> 
[snip]

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
