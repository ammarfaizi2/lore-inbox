Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUBGFZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266636AbUBGFZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:25:27 -0500
Received: from ns.suse.de ([195.135.220.2]:40410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266604AbUBGFZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:25:26 -0500
Date: Sat, 7 Feb 2004 06:21:11 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
Message-Id: <20040207062111.4ddd268c.ak@suse.de>
In-Reply-To: <14230000.1076129379@[10.10.2.4]>
References: <51080000.1075936626@flay.suse.lists.linux.kernel>
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
	<p738yjflf38.fsf@verdi.suse.de>
	<14230000.1076129379@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Feb 2004 20:49:40 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> Not quite sure what you mean ... I was driving at pretending an SMP box
> was NUMA ... but the x86_64 is already NUMA ... are you grouping nodes
> together into single nodes with 2 cpus each?

There are Opteron boxes which are not NUMA. Or rather they are NUMA, but only
have a single node. Some of the cheaper boards only connect the DIMM
slots to a single CPU, which gives you only a single node even with
two CPUs. One of the test machines I have here is of this type. 

It's also useful for testing on simulators.

> Andi, do you already set up the mem allocation fallback zonelists like that?

I don't do anything special, it's all generic page_alloc.c logic.
 
-Andi
