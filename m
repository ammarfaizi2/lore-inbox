Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVGMTPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVGMTPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGMTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:15:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1733 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262492AbVGMTNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:13:49 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 15:13:44 -0400
Message-Id: <1121282025.4435.70.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> So we should aim for a HZ value that makes it easy to convert to and from
> the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> good values for that reason. 864 is not.

How about 500?  This might be good enough to solve the MIDI problem.

Lee

