Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTLDQgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTLDQgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:36:47 -0500
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:23826 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262719AbTLDQgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:36:45 -0500
Date: Thu, 4 Dec 2003 11:32:43 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031204163243.GA10471@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FCF25F2.6060008@netzentry.com> <1070551149.4063.8.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070551149.4063.8.camel@athlonxp.bradney.info>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm i686
X-Uptime: 11:23:23 up 19:49,  9 users,  load average: 0.18, 0.42, 3.20
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Dec 04, 2003 at 04:19:10PM +0100, Craig Bradney wrote:
> As reported earlier today I had the first lockup this morning in over 5
> days uptime. Having had that, I decided to go for the latest gentoo 2.6
> test 11-r1 kernel. This means I was now running the following patches:
> http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.7/
> instead of
> http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.6/
> on top of vanilla test 11.
> 
> Anyway.. my two changes on rebuilding the kernel were initially:
> -Add in preempt (because there were questions asked here) 
> -Remove generic IDE support (I know I have Nvidia IDE so lets only have
> that one).
> 
> In that configuration the "multiple hdparm -t /dev/hda" test hung my
> system.
> 
> Rebuilt kernel without preempt.. no hang on hdparm test. 
> 
> So in summary, apart from the patch changes as above, the only
> difference is to my 5 day kernel I now dont have generic IDE support
> included.
> 
> So now, I'll leave it on and see how far it goes.. 13 mins so far :).
> 
> regards
> Craig
> 
> 

Just to add more inconsistency into the mix, I am running with preempt
enabled, generic ide disabled, and can't make it crash.  Ran netperf for
an hour over a crossover cable on 100mbit, a couple make -j 30 kernel
compiles, dbench, and playing some mp3's all at the same time and
nothing happens despite load average reaching over 100.  Maybe I am just
lucky.


-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
