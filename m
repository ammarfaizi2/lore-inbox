Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUJDB6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUJDB6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUJDB6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 21:58:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39315 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268311AbUJDB6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 21:58:33 -0400
Date: Sun, 3 Oct 2004 18:56:10 -0700
From: Paul Jackson <pj@sgi.com>
To: Tim Hockin <thockin@hockin.org>
Cc: mbligh@aracnet.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003185610.3bbff226.pj@sgi.com>
In-Reply-To: <20041003201005.GA27757@hockin.org>
References: <247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003201005.GA27757@hockin.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim wrote:
> 7 years ago, before cpus_allowed was dreamed up, I proposed a pset patch

One more thing ... the original message from Simon and Sylvain that I
first saw a year ago announcing their cpuset work, which is the basis
for the current cpuset patch in Andrew's tree, began with the lines:


> From: Simon Derr <Simon.Derr@bull.net>
> Date: Wed, 24 Sep 2003 17:59:01 +0200 (DFT)
> To: lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
> cc: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
> 
> We have developped a new feature in the Linux kernel, controlling CPU
> placements, which are useful on large SMP machines, especially NUMA ones.
> We call it CPUSETS, and we would highly appreciate to know about anyone
> who would be interested in such a feature. This has been somewhat inspired
> by the pset or cpumemset patches existing for Linux 2.4.


So I guess Tim, you (pset) and I (cpumemset) can both claim to
have developed anticedents of this current cpuset proposal.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
