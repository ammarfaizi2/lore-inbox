Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbULAVlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbULAVlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbULAVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:41:21 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1275 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261459AbULAVlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:41:17 -0500
Message-ID: <41AE3A51.9080304@nortelnetworks.com>
Date: Wed, 01 Dec 2004 15:40:33 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Esben Nielsen <simlo@phys.au.dk>, Paul Davis <paul@linuxaudiosystems.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
References: <20041201155353.GA30193@elte.hu> <Pine.OSF.4.05.10412011708520.8736-100000@da410.ifa.au.dk> <20041201212413.GF22671@elte.hu>
In-Reply-To: <20041201212413.GF22671@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> actually, the main problem with fifos was they were _not_ atomic even in
> read/write (i myself fully expected them to be that, but they arent). 
> That's the bug/misfeature that i fixed in the latest kernels.

Whoa.  pipes (ie from the pipe() call) don't read/write atomicly? Even if you 
write less than a page?

When was this fixed?

Chris
