Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129065AbQHUJfd>; Mon, 21 Aug 2000 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129060AbQHUJfX>; Mon, 21 Aug 2000 05:35:23 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:50960 "EHLO ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id <S129040AbQHUJfS>; Mon, 21 Aug 2000 05:35:18 -0400
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256942.00334530.00@d73mta05.au.ibm.com>
Date: Mon, 21 Aug 2000 14:48:17 +0530
Subject: Dynamic Probes Announcement
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IBM Linux Technology Centre announced on August 16, the first release
of Dynamic Probes (Dprobes)
available from
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

Dprobes is a generic and pervasive system debugging facility that will
operate under the most extreme software conditions such as debugging a deep
rooted operating system problem in a live environment.  For example,
page-manager bugs in the kernel or perhaps user or system problems that
will not re-create easily in either a lab or production environment.  For
such inaccessible problem scenarios Dynamic Probes not only offers a
technique for gathering diagnostic information but has a high probability
of successful outcome without the need to build custom modules for
debugging purposes.

Dprobes allows the insertion of fully automated breakpoints or probepoints,
anywhere in the system and user space.  Each probepoint has an associated
set of probe instructions that are interpreted when the probe fires.  These
instructions allow memory and CPU registers to be examined and altered
using conditional logic.  When the probe command terminates, prior to
returning to the probed code, a syslog record may be optionally generated.

Our intention in the next Dprobes code drop is that the probe program will
be used to trigger any external debugging facility that registers for this
purpose. For example a trace program will be able to augment its capability
with a dynamic trace capability.  Similarly, a crash dump facility will be
able to be invoked conditionally when a specific set of circumstances
occurs in a particular code path.  and lastly a debugger will be able to
use Dprobes as high-speed complex conditional breakpoint service.


  Suparna Bhattacharya
  IBM Linux Technology Centre, RAS
  Systems Software, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
