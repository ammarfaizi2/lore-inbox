Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUG3WWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUG3WWC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUG3WWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:22:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4304 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267859AbUG3WSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:18:53 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200407300836.32812.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	 <200407290843.46116.jbarnes@engr.sgi.com> <1091139818.4070.7.camel@arrakis>
	 <200407300836.32812.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091225824.5925.1.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Jul 2004 15:17:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 08:36, Jesse Barnes wrote:
> I think this will work.  My tree didn't have nodemask_t though, so it didn't 
> compile :)  Here's a first stab at an ia64 portion of the patch.
> 
> Jesse

Andrew picked it up in 2.6.8-rc2-mm1, so if you base your patch against
that it should compile...  That's what I based my patch off.  Our lab
has been down for a few days so I hope to do some testing on Monday for
my patches.  If all goes well, I'll add your code into my patch and
submit it early next week, ok?

Thanks!

-Matt

