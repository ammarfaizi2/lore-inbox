Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbVLROYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbVLROYA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 09:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVLROYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 09:24:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37771 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932702AbVLROYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 09:24:00 -0500
Date: Tue, 29 Nov 2005 14:08:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, Andrew Morton <akpm@osdl.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051129130843.GA9991@openzaurus.ucw.cz>
References: <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu> <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu> <1132367947.5706.11.camel@localhost.localdomain> <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133232503.6328.18.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Description:
> 
> This patch creates a directory in /sys/kernel called idle.  This
> directory contains two files: idle_ctrl and idle_methods.  Reading
> idle_ctrl will show the function that is currently being used for idle,
> and idle_methods shows the available methods for the user to send write
> into idle_ctrl to change which function to use for idle.

Pretty ugly interface, I'd say... is listing function really neccessary?

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

