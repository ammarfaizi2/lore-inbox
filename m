Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271347AbTGQJAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271350AbTGQJAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:00:06 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:6550
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271347AbTGQJAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:00:04 -0400
Message-ID: <1058433295.3f16690fa2f2e@kolivas.org>
Date: Thu, 17 Jul 2003 19:14:55 +1000
From: Con Kolivas <kernel@kolivas.org>
To: alexander.riesen@synopsys.COM
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity
References: <200307170030.25934.kernel@kolivas.org> <20030717090508.GE13611@Synopsys.COM>
In-Reply-To: <20030717090508.GE13611@Synopsys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Riesen <alexander.riesen@synopsys.COM>:

> Con Kolivas, Wed, Jul 16, 2003 16:30:25 +0200:
> > O*int patches trying to improve the interactivity of the 2.5/6 scheduler
> for 
> > desktops. It appears possible to do this without moving to nanosecond 
> > resolution.
> > 
> > This one makes a massive difference... Please test this to death.
> > 
> 
> tar ztf file.tar.gz and make something somehow do not like each other.
> Usually it is tar, which became very slow. And listings of directories
> are slow if system is under load (about 3), too (most annoying).
> 
> UP P3-700, preempt. 2.6.0-test1-mm1 + O6-int.

Thanks for testing. It is distinctly possible that O6.1 addresses this problem. 
Can you please test that? It applies on top of O6 and only requires a recompile 
of sched.o.

http://kernel.kolivas.org/2.5

Con
