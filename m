Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUBGDyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUBGDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:54:09 -0500
Received: from ns.suse.de ([195.135.220.2]:9904 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265175AbUBGDyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:54:07 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
References: <51080000.1075936626@flay.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402041539470.2086@home.osdl.org.suse.lists.linux.kernel>
	<60330000.1075939958@flay.suse.lists.linux.kernel>
	<64260000.1075941399@flay.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402041639420.2086@home.osdl.org.suse.lists.linux.kernel>
	<20040204165620.3d608798.akpm@osdl.org.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402041719300.2086@home.osdl.org.suse.lists.linux.kernel>
	<1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402041800320.2086@home.osdl.org.suse.lists.linux.kernel>
	<98220000.1076051821@[10.10.2.4].suse.lists.linux.kernel>
	<1076061476.27855.1144.camel@nighthawk.suse.lists.linux.kernel>
	<5450000.1076082574@[10.10.2.4].suse.lists.linux.kernel>
	<1076088169.29478.2928.camel@nighthawk.suse.lists.linux.kernel>
	<218650000.1076097590@flay.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402061215030.30672@home.osdl.org.suse.lists.linux.kernel>
	<220850000.1076102320@flay.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Feb 2004 04:54:03 +0100
In-Reply-To: <220850000.1076102320@flay.suse.lists.linux.kernel>
Message-ID: <p738yjflf38.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
 
> If we really want to do good testing, we should make a fake NUMA config
> that can run a 4x SMP box as fake NUMA, with half the memory in each
> "node" and half the processors ... but I never got around to coding that ;-)

I have such a patch for x86-64 if anybody is interested in that.

x86-64 low level NUMA is quite different from IA32 NUMA though so it 
would be a bit difficult to port.

-Andi
