Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSG3DGN>; Mon, 29 Jul 2002 23:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSG3DGN>; Mon, 29 Jul 2002 23:06:13 -0400
Received: from mail.MtRoyal.AB.CA ([142.109.10.24]:494 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S318209AbSG3DGM>; Mon, 29 Jul 2002 23:06:12 -0400
Date: Mon, 29 Jul 2002 21:09:19 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Andrew Theurer <habanero@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <000f01c23766$a04259d0$2c060e09@beavis>
Message-ID: <Pine.LNX.4.44.0207292101230.23799-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Andrew Theurer wrote:

> 
> Thanks for the info.  Did you get any performance results for before and
> after?  I did try Ingo's patch a while back, and I experienced about a 8%
> drop in performance.  I did not have hyperthreading on, just a simple case
> comparing balance to no balance.  The overhead of the ioapic programming was
> too high.  Increasing the time between reroutes by 20 got me back to the
> same performance as no balancing at all.  I intend to test his patch again,
> along with Andrea's next.

The http://www.hardrock.org/HT-results/ output is with and without
hyper threading.

The balancing patch was applied to both sets of tests.  

The system is now in production, therefore I can't do the same tests on it
without the routing patches (note there are 2, one for
everything but the timer, and one for the timer).

We will be receiving several new Dell systems (1650, 2650, and
6650 models) and I know that at least the 2650 and 6650 are P4
with the server works GC chipset, so I may be able to run some tests
on those, given I have the time to do it.

Regards
James Bourne

> 
> -Andrew Theurer
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


