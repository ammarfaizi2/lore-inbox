Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278781AbRJVMsU>; Mon, 22 Oct 2001 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278785AbRJVMsK>; Mon, 22 Oct 2001 08:48:10 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:54951 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S278781AbRJVMr7>; Mon, 22 Oct 2001 08:47:59 -0400
X-Lotus-FromDomain: IBMIN@IBMAU
From: vamsi_krishna@in.ibm.com
To: ltc@linux.ibm.com, dprobes@www-124.southbury.usf.ibm.com
cc: patrick.s.thomson@intel.com, linux-kernel@vger.kernel.org
Message-ID: <CA256AED.0045FEC3.00@d73mta01.au.ibm.com>
Date: Mon, 22 Oct 2001 18:16:32 +0530
Subject: [Announce] Dynamic Probes v3.0 Released
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Probes v 3.0 is released.

Dynamic Probes is a generic and pervasive debugging facility that will
operate under the most extreme software conditions such as debugging a
deep rooted operating system problem in a live environment.

We have released the next major version of Dynamic Probes. It can be
downloaded from the project website at:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/

Brief Changelog:

Dynamic Probes can now be built as a kernel module. It now uses generalized
kernel hooks which reduces the overhead on the system when dprobes is
compiled in, but dormant.

- use kernel hooks (gkhi)
- remove system call, dprobes is now a character driver and user-space
  interface is through ioctls
- dprobes can be built as a module
- watchpoint probes ("Global Debug Registers"/CONFIG_DR_ALLOC) can now be
  turned off in the build
- new call_kmod instruction
- new log target, posix event log
- bug fixes/cleanup in query/getvars
- fix exit to kdb so that backtrace works
- implement ros instruction
- cmdl.l fix to accept '-' in names (mmlnx@linux.ibm.com)
- upgrade to 2.4.12 (patch for 2.4.6 also available)

* please refer to the README in the package for kernel build configuration
  options, which have changed significantly. You now need to enable the
  Kernel Hooks support to see the DProbes build options.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi_krishna@in.ibm.com


