Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTF3OHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTF3OHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:07:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14295 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264304AbTF3OHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:07:10 -0400
Subject: Evaluation of three I/O schedulers
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, "Mike Sullivan" <mksully@us.ibm.com>,
       "Bill Hartner" <bhartner@us.ibm.com>,
       "Ray Venditti" <venditti@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF9393D547.0D1D003C-ON85256D55.004DFAA4@pok.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 30 Jun 2003 09:21:24 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 06/30/2003 10:21:28 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We used 2.5.72+mm1 to evaluate three I/O schedulers, namely
anticipatory, deadline and complete fair queueing under a very heavy
database workload on an 8-way Pentium 4 machine. The workload is a
decision support system doing mostly sequential I/O and each run takes
about one hour. All three runs finished completely without encountering
functional problems, and achieved similar performance level.

The 8-way machine has Pentium 4 2.0 GHz processors, 16 GB physical
memory, 2MB L3 cache, 8 FC controllers with 80 disks. Hyperthreading
was turned on for the three runs. The CPU utilization is similar for all
three runs: 65% user, 7% system and 28% idle.

Regards,
Peter

Peter Wai Yee Wong
IBM Linux Technology Center Performance Team
email: wpeter@us.ibm.com


