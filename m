Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUBFURX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBFURX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:17:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:32706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265654AbUBFURV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:17:21 -0500
Date: Fri, 6 Feb 2004 12:16:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Dave Hansen <haveblue@us.ibm.com>, Keith Mannthey <kmannth@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@muc.de>
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <218650000.1076097590@flay>
Message-ID: <Pine.LNX.4.58.0402061215030.30672@home.osdl.org>
References: <51080000.1075936626@flay>
 <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay>
 <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
 <20040204165620.3d608798.akpm@osdl.org> <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
 <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
 <Pine.LNX.4.58.0402041800320.2086@home.osdl.org> <98220000.1076051821@[10.10.2.4]>
 <1076061476.27855.1144.camel@nighthawk> <5450000.1076082574@[10.10.2.4]>
 <1076088169.29478.2928.camel@nighthawk> <218650000.1076097590@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Feb 2004, Martin J. Bligh wrote:
> 
> Ah ... that's the problem. That's not a valid config

It really _should_ be a valid config, though. Otherwise, nobody can ever 
test it in any reasonable way on a regular PC.

So why not allow a NuMA config for a PC (and it should end up as being 
just one node, of course)?

		Linus
