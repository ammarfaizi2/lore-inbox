Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSLCNWp>; Tue, 3 Dec 2002 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSLCNWp>; Tue, 3 Dec 2002 08:22:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28341 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261486AbSLCNWo>;
	Tue, 3 Dec 2002 08:22:44 -0500
Date: Tue, 3 Dec 2002 13:26:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: "Vamsi Krishna S ." <vamsi@in.ibm.com>, torvalds@transmeta.com,
       lkml <linux-kernel@vger.kernel.org>,
       dprobes <dprobes@www-124.southbury.usf.ibm.com>,
       richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.50-bk2
Message-ID: <20021203132621.GA811@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@suse.de>, "Vamsi Krishna S ." <vamsi@in.ibm.com>,
	torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>,
	dprobes <dprobes@www-124.southbury.usf.ibm.com>,
	richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
References: <20021203125447.A2951@in.ibm.com.suse.lists.linux.kernel> <20021203121858.GC30431@suse.de.suse.lists.linux.kernel> <p734r9vtg62.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734r9vtg62.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 01:56:05PM +0100, Andi Kleen wrote:

 > > This last part just got me thinking.
 > > What stops someone for example using this to implement a binary
 > > only replacement of the TCP/IP stack, or any other part of the
 > > kernel for that matter ?
 > 
 > It can be already easily done, just patch the kernel code in /dev/kmem
 > and add some jump instructions to your loaded module.
 > But it's not practical, because it's 100% binary dependent and would
 > break with every small change.

indeed.
 
 > Similar to kprobes. But kprobes is actually useful for kernel debugging/
 > tracing and unlike many other of these patches not very intrusive.

Suparna also just told me I overlooked the _GPL on the export.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
