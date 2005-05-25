Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVEYVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVEYVDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVEYVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:03:19 -0400
Received: from graphe.net ([209.204.138.32]:1703 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261565AbVEYVDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:03:16 -0400
Date: Wed, 25 May 2005 14:03:06 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <4294C39B.1040401@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505251402090.15286@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
 <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com>
 <Pine.LNX.4.62.0505201210460.390@graphe.net> <428E56EE.4050400@us.ibm.com>
 <Pine.LNX.4.62.0505241436460.3878@graphe.net> <4293B292.6010301@us.ibm.com>
 <Pine.LNX.4.62.0505242221340.7191@graphe.net> <4294C39B.1040401@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Matthew Dobson wrote:

> > Umm.. How does it fail? Any relationship to the slab allocator?
> 
> It dies really early om my x86 box.  I'm not 100% sure that it is b/c of
> your patches, since it dies so early I get nothing on the console.  Grub
> tells me it's loading the kernel image then....  nothing.

Hmmm. Do you have an emulator? For IA32 and IA64 we have something that 
simulates a boot up sequence and can tell us what is going on.
