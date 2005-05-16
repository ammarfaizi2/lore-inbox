Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVEPTfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVEPTfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEPTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:33:37 -0400
Received: from palrel10.hp.com ([156.153.255.245]:16829 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261818AbVEPT3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:29:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17032.62615.750699.18847@napali.hpl.hp.com>
Date: Mon, 16 May 2005 12:29:27 -0700
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Subject: Re: IA64 implementation of timesource for new time of day subsystem
In-Reply-To: <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	<1116029872.26454.4.camel@cog.beaverton.ibm.com>
	<1116029971.26454.7.camel@cog.beaverton.ibm.com>
	<1116030058.26454.10.camel@cog.beaverton.ibm.com>
	<1116030139.26454.13.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	<1116264858.26990.39.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
	<1116269136.26990.67.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 16 May 2005 12:24:08 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:

  Christoph> Other IA64 vendors will see that their timer performance
  Christoph> drops significantly after the new timer subsystem is
  Christoph> in. IBM no longer has IA64 systems that rely on ITC?

Would that somehow make it ok to break existing and working code?

	--david
