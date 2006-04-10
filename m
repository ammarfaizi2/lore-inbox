Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWDJJNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWDJJNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWDJJNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:13:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:28850 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751038AbWDJJNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:13:09 -0400
Date: Mon, 10 Apr 2006 11:12:59 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Message-ID: <20060410091248.GA32468@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Peter Williams <pwil3058@bigpond.net.au>
References: <1144402690.7857.31.camel@homer> <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer> <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer> <20060409111436.GA26533@outpost.ds9a.nl> <1144582778.13991.10.camel@homer> <20060409121436.GA28075@outpost.ds9a.nl> <1144606061.7408.14.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144606061.7408.14.camel@homer>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 08:07:41PM +0200, Mike Galbraith wrote:
> Rare?  What exactly is rare about a number of tasks serving data?  I
> don't care if it's a P4 serving gigabit.  If you have to divide your
> server into pieces (you do, and you know it) you're screwed. 

You've not detailed your load. I assume it consists of lots of small files
being transferred over 10 apache processes? I also assume you max out your
system using apachebench? 

In general, Linux systems are not maxed out as they will disappoint that way
(like any system running with id=0). 

So yes, what you do is a 'rare load' as anybody trying to do this will
disappoint his users.

And any tweak you make to the scheduler this way is bound to affect another
load.

	Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
