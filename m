Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFBRey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFBRey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFBRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:34:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:29319 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261208AbVFBReu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:34:50 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <200506012037.53226.kernel-stuff@comcast.net>
References: <1117667378.6801.80.camel@cog.beaverton.ibm.com>
	 <1117667536.17474.0.camel@cog.beaverton.ibm.com>
	 <1117667631.17474.3.camel@cog.beaverton.ibm.com>
	 <200506012037.53226.kernel-stuff@comcast.net>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 10:34:39 -0700
Message-Id: <1117733679.17804.7.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 20:37 -0400, Parag Warudkar wrote:
> On Wednesday 01 June 2005 19:13, john stultz wrote:
> > This patch converts the x86-64 arch to use the new timeofday
> > infrastructure. It applies on top of my timeofday-core_B1 patch.
> 
> This one fails to apply - time.c HUNK #1 gets rejected. (Attached)

Yea, sorry. My naming scheme isn't quite granular enough. The patch is
against Linus' git tree as of yesterday, not -rc5 vanilla. 

If you grab Linus' current tree it should apply.

Sorry about the confusion.
-john

