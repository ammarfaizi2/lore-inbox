Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUBFVTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266701AbUBFVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:19:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49878 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265628AbUBFVT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:19:29 -0500
Date: Fri, 06 Feb 2004 13:18:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Dave Hansen <haveblue@us.ibm.com>, Keith Mannthey <kmannth@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@muc.de>
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <220850000.1076102320@flay>
In-Reply-To: <Pine.LNX.4.58.0402061215030.30672@home.osdl.org>
References: <51080000.1075936626@flay><Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay><64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org><20040204165620.3d608798.akpm@osdl.org> <Pine.LNX.4.58.0402041719300.2086@home.osdl.org><1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com><Pine.LNX.4.58.0402041800320.2086@home.osdl.org> <98220000.1076051821@[10.10.2.4]><1076061476.27855.1144.camel@nighthawk> <5450000.1076082574@[10.10.2.4]><1076088169.29478.2928.camel@nighthawk> <218650000.1076097590@flay> <Pine.LNX.4.58.0402061215030.30672@home.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 6 Feb 2004, Martin J. Bligh wrote:
>> 
>> Ah ... that's the problem. That's not a valid config
> 
> It really _should_ be a valid config, though. Otherwise, nobody can ever 
> test it in any reasonable way on a regular PC.
> 
> So why not allow a NuMA config for a PC (and it should end up as being 
> just one node, of course)?

We have that - it's what the generic arch is. It's also good for distros, 
as it'll enable them to build one binary kernel and run it on flat SMP 
boxes and the Summit/x440 boxes.

If we really want to do good testing, we should make a fake NUMA config
that can run a 4x SMP box as fake NUMA, with half the memory in each
"node" and half the processors ... but I never got around to coding that ;-)

M.

