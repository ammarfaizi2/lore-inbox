Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbTCRUs7>; Tue, 18 Mar 2003 15:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbTCRUs7>; Tue, 18 Mar 2003 15:48:59 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:33664 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S262572AbTCRUs6>;
	Tue, 18 Mar 2003 15:48:58 -0500
Date: Tue, 18 Mar 2003 12:59:07 -0800
From: Jerry Cooperstein <coop@axian.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew problems
Message-ID: <20030318205907.GB4081@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com> <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 12:32:24PM -0800, Stephen Hemminger wrote:
> On Tue, 2003-03-18 at 11:05, Jerry Cooperstein wrote:
> > Since 2.5.60 my thinkpad keyboard repeat rate has been erratic when
....

> 
> Does this notebook vary the clock rate? If so then using TSC for 
> time of day clock is probably a problem.  Try booting with notsc.

Yes the notebook varies the clock rate -- its about 150MHZ with
batter power, 500 MHZ on AC.

I tried booting with notsc, the results were:

for kernels through 2.5.63:  kernel panic on boot, message saying pentium+
requires tsc

for 2.5.64, 2.5.65:  no failure, but no help.

Merci

coop

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================

