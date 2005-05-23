Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVEWPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVEWPxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVEWPxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:53:31 -0400
Received: from fmr20.intel.com ([134.134.136.19]:39369 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261901AbVEWPr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:47:26 -0400
Message-Id: <20050523153906.988390000@csdlinux-2.jf.intel.com>
Date: Mon, 23 May 2005 08:39:06 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org
Cc: tony.luck@intel.com, rohit.seth@intel.com, rusty.lynch@intel.com,
       prasanna@in.ibm.com, ananth@in.ibm.com, systemtap@sources.redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: [patch 0/4] Kprobes support for IA64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	As many of you know that kprobes exist in the main line kernel
for various architecture including i386, x86_64, ppc64 and sparc64.
Attached patches following this mail are a port of Kprobes and Jprobes for IA64.

I have tesed this patches for kprobes and Jprobes and this seems to work fine.
I have tested this patch by inserting kprobes on various slots and
various templates including various types of branch instructions.

I have also tested this patch using the tool 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111657358022586&w=2
and the kprobes for IA64 works great.

This path depends on 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111634286225988&w=2
which is in your mm tree.

Here is list of TODO things and pathes for the same will appear soon.
1) Support kprobes on "mov r1=ip" type of instruction
2) Support Kprobes and Jprobes to exist on the same address
3) Support Return probes
3) Architecture independent cleanup of kprobes

I am sending this mail through quilt and looks like the subject line appear to be
same on all patches, sorry about that.

Please apply.

Thanks,

-Anil Keshavamurthy
Sr. Software Engineer
Open Source Technology Center/SSG
Intel Corp.
(w) 503-712-4476

--
