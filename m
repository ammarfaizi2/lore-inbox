Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbTDVPBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTDVPAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:00:15 -0400
Received: from holomorphy.com ([66.224.33.161]:923 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263194AbTDVO7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:59:30 -0400
Date: Tue, 22 Apr 2003 08:10:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@redhat.com>,
       Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422151054.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
	dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030405143138.27003289.akpm@digeo.com> <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com> <20030422123719.GH23320@dualathlon.random> <20030422132013.GF8931@holomorphy.com> <171790000.1051022316@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171790000.1051022316@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 07:38:37AM -0700, Martin J. Bligh wrote:
> where the list of address_ranges is sorted by start address. This is
> intended to make use of the real-world case that many things (like shared
> libs) map the same exact address ranges over and over again (ie something
> like 3 ranges, but hundreds or thousands of mappings).

I'd have to see an empirical demonstration or some previously published
analysis (or previously published empirical demonstration) to believe
this does as it should.

Not to slight the originator, but it is a technique without an a priori
time (or possibly space either) guarantee, so the trials are warranted.

I'm overstating the argument because it's hard to make it sound slight;
it's very plausible something like this could resolve the time issue.


-- wli
