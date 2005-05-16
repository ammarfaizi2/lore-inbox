Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVEPS4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVEPS4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEPS4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:56:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63890 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261814AbVEPSzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:55:49 -0400
Subject: Re: IA64 implementation of timesource for new time of day subsystem
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <1116269136.26990.67.camel@cog.beaverton.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	 <1116264858.26990.39.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
	 <1116269136.26990.67.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:55:42 -0700
Message-Id: <1116269742.26990.74.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 11:45 -0700, john stultz wrote:
> All you need is to do is define  implement an ia64 version of
> arch_update_vsyscall_gtod() which can then export the values passed to
> it in whatever form you desire so it can be used by the fastcall.


Sorry, that first sentence wasn't complete, I went to go look up the
reference and got distracted with something else.

It should be "All you need to do is define NEWTOD_VSYSCALL and
implement.."

time for more coffee :)
-john


