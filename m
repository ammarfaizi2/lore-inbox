Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbTCFWrv>; Thu, 6 Mar 2003 17:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268483AbTCFWru>; Thu, 6 Mar 2003 17:47:50 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:10934
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S268472AbTCFWqh>; Thu, 6 Mar 2003 17:46:37 -0500
Date: Thu, 6 Mar 2003 17:31:26 -0500 (EST)
From: "Dimitrie O. Paun" <dimi@intelliware.ca>
X-X-Sender: dimi@dimi.dssd.ca
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <13680000.1046988847@flay>
Message-ID: <Pine.LNX.4.44.0303061725330.23356-100000@dimi.dssd.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.103.156.204] using ID <dpaun@rogers.com> at Thu, 6 Mar 2003 17:57:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Martin J. Bligh wrote:

> Difficult to see how this would work. For instance, is bash interactive 
> or a batch job?

Right, being able to control this interactivity knob programmatically
seems like a useful thing. That way, the window manager can boost the
interactivity of the foreground window for example. It does seem that
figuring out that something is interactive in the scheduler is tough,
there is just not enough information, whereas a higher layer may know
this for a fact. I guess this reduces my argument to just keeping the 
interactivity setting separate from priority.

-- 
Dimi.

