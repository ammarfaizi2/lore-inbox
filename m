Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271595AbTGQWLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGQWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:11:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55707
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271595AbTGQWLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:11:10 -0400
Date: Fri, 18 Jul 2003 00:26:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030717222657.GW1855@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <200307180013.38078.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307180013.38078.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:13:38AM +0200, Marc-Christian Petersen wrote:
> 2.4.22-pre[6|6aa1]: ~ 1 minute 02 seconds from: Start this virtual machine ...
> 2.4.22-pre2       : ~          30 seconds from: Start this virtual machine ...
> 
> ... to start up Windows 2000 Professional completely.

can you check what's doing? reading or writing? I guess it's a kind of
workload that would seek all over the place.  However throughput should
be better with seeks now since I could grow the queue (if something only
latency would be worse but the above is a throughput thing only, latency
doesn't matter).

Can you retry once more time with pre2 vs pre6 to be 100% sure it's
reproducible?

thanks,

Andrea
