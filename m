Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAZQfw>; Fri, 26 Jan 2001 11:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbRAZQfm>; Fri, 26 Jan 2001 11:35:42 -0500
Received: from palrel3.hp.com ([156.153.255.226]:59910 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129868AbRAZQfW>;
	Fri, 26 Jan 2001 11:35:22 -0500
From: Scott Rhine <rhine@rsn.hp.com>
Message-Id: <200101261635.KAA23305@hueco-e.rsn.hp.com>
Subject: plug-in schedulers for linux 2_4_0
To: linux-kernel@vger.kernel.org, linux-announce@sws1.ctd.ornl.gov
Date: Fri, 26 Jan 2001 10:35:13 CST
Cc: romero@hueco-e.rsn.hp.com, mcarl@hueco-e.rsn.hp.com
X-Mailer: Elm [revision: 111.1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last month, there have been a few more minor changes to Loadable
Schedulers for Linux.  Both a new patch to the base kernels and deltas to
previous downloads are provided.  If you download new utilities be sure to
download the new kernel, or libpset calls may not behave properly!

Changes included:
 * support for the official release of Linux 2_4_0
 + a misleading print line in the sched_rr benchmark has been removed.
 + the psetps utility further bullet-proofed against buffer overflow.
 + our pset idtype_t has been replaced universally with the portable
   type from the standardized include file <sys/wait.h>. In all utilities and
   the kernel, PS_PID has been replaced with P_PID.

One note for those using processor sets with animation.  Make certain that
the X server or other display daemons are in the same pset as the application
attempting to use the display.  Otherwise, performance may suffer.

Watch for our demonstration at the HP booth at Linux World and our
presentation at Interworks!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
