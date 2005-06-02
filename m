Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFBXlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFBXlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFBXlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:41:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12767 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261477AbVFBXjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:39:12 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Thu, 2 Jun 2005 19:33:58 -0400
User-Agent: KMail/1.8
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com>
In-Reply-To: <1117754453.17804.51.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021933.59470.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 19:20, john stultz wrote:
> Could you see if the slowness you're feeling is correlated to the
> acpi_pm timesource? It is quite a bit slower to access then the TSC, but
> I'd be surprised if you can actually feel the difference.

Will try that.

>
> This is on an x86-64 system, correct?

Yes, correct.

Parag
-- 
It is exactly because a man cannot do a thing that he is a proper judge of it.
		-- Oscar Wilde
