Return-Path: <linux-kernel-owner+w=401wt.eu-S1754867AbWL2PDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbWL2PDD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbWL2PDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:03:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbWL2PDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:03:01 -0500
Date: Fri, 29 Dec 2006 10:02:53 -0500
From: Dave Jones <davej@redhat.com>
To: maximilian attems <maks@sternwelten.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061229150253.GB4516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	maximilian attems <maks@sternwelten.at>,
	linux-kernel@vger.kernel.org
References: <20061228193943.GC8940@redhat.com> <20061229092314.GB24061@nancy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229092314.GB24061@nancy>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 10:23:14AM +0100, maximilian attems wrote:
 > > On Thu, Dec 28, 2006 at 11:21:21AM -0800, Linus Torvalds wrote:
 > >  > 
 > >  > 
 > >  > On Thu, 28 Dec 2006, Petri Kaukasoina wrote:
 > >  > > > me up), and that seems to show the corruption going way way back (ie going 
 > >  > > > back to Linux-2.6.5 at least, according to one tester).
 > >  > > 
 > >  > > That was a Fedora kernel. Has anyone seen the corruption in vanilla 2.6.18
 > >  > > (or older)?
 > >  > 
 > >  > Well, that was a really _old_ fedora kernel. I guarantee you it didn't 
 > >  > have the page throttling patches in it, those were written this summer. So 
 > >  > it would either have to be Fedora carrying around another patch that just 
 > >  > happens to result in the same corruption for _years_, or it's the same 
 > >  > bug.
 > > 
 > > The only notable VM patch in Fedora kernels of that vintage that I recall
 > > was Ingo's 4g/4g thing.
 > 
 > no the fedora 2.6.18 kernel is affected.

I wasn't denying that, but Linus was talking about a 2.6.5 Fedora kernel.

 > it carries the same -mm patches that Debian backported
 > for LSB 3.1 compliance.

The only -mm stuff I recall being in the Fedora 2.6.18 is
the inode-diet stuff which ended up in 2.6.19, though the xmas
break has left my head somewhat empty so I may be forgetting something.
What patch in particular are you talking about?

		Dave

-- 
http://www.codemonkey.org.uk
