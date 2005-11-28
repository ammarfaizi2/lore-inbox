Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVK1RwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVK1RwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVK1RwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:52:00 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:21948 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932144AbVK1Rv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:51:58 -0500
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
From: Lee Revell <rlrevell@joe-job.com>
To: thockin@hockin.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051128173040.GA32547@hockin.org>
References: <1133179554.11491.3.camel@localhost.localdomain>
	 <20051128173040.GA32547@hockin.org>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 12:39:28 -0500
Message-Id: <1133199568.7416.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 09:30 -0800, thockin@hockin.org wrote:
> The kernel's use of TSC is wholly incorrect.  TSCs can ramp up and
> down and *do* vary between nodes as well as between cores within a
> node.  You really can not compare TSCs between cpu cores at all, as is
> (and the kernel assumes 1 global TSC in at least a few places). 

That's one way to look at it; another is that the AMD dual cores have a
broken TSC implementation.  The kernel's use of the TSC was never a
problem in the past...

Lee

