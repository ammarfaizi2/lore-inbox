Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUHNIzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUHNIzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUHNIzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:55:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:475 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266198AbUHNIys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:54:48 -0400
Date: Sat, 14 Aug 2004 01:51:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: frankeh@watson.ibm.com, efocht@hpce.nec.com, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20040814015139.5d49492a.pj@sgi.com>
In-Reply-To: <41194E49.2000300@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<200408071722.36705.efocht@hpce.nec.com>
	<41168B97.1010704@watson.ibm.com>
	<41179ED1.2000909@watson.ibm.com>
	<20040810043120.23aaf071.pj@sgi.com>
	<41194E49.2000300@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh writes:
> But do let us know if there is interest in merging 
> (after this round of clarificatory emails is over) as it will affect 
> which way we go.

I remain convinced that such a merging would be wrong headed.

When I examine the experience that other operating systems such as
Solaris, Unicos and Irix have had with resource share groups and
cpusets, they have considered these to be two distinct facilities,
correctly so in my view.

So I recommend that you not try to bend CKRM to include cpusets.

Unless others have more to say, I too am content to close this thread
for now.  I've email-bombed enough mail boxes for one week ;).

I'll have an updated cpuset patch, hopefully next week, hopefully
with a shorter Cc list this time, with a couple of modest fixes.

Thank-you.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
