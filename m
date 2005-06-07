Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVFGXBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVFGXBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVFGXBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:01:05 -0400
Received: from dvhart.com ([64.146.134.43]:20136 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262027AbVFGXA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:00:57 -0400
Date: Tue, 07 Jun 2005 16:00:53 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Adam Litke <agl@us.ibm.com>, Enrique Gaona <egaona@us.ibm.com>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Message-ID: <997150000.1118185253@flay>
In-Reply-To: <531740000.1117749798@flay>
References: <531740000.1117749798@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I've finally got this to the point where I can publish it.
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

...

> Clicking on the failure ones error codes should take you to somewhere
> vaguely helpful to diagnose it. Clicking on the job number just below
> that takes you to the info I'm publishing right now, which should 
> include perf results and profiles, etc. I'll add graphs, etc later,
> comparing performance across kernels (I have them ... just not automated).

OK, there's performance graphs out there for tbench, dbench, kernbench,
and reaim now.

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/perf_matrix.html

-mm seems to be rather sucky on kernbench recently, I'll have a drill down
into why, and try to send out some more data later on. The vertical bars
on the kernbench graph are std deviation between sets of runs (a rough
error margin).

Suggestions for improvements welcome ...

M.

