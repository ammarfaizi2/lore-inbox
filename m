Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVAGViU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVAGViU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAGVgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:36:38 -0500
Received: from mail.tyan.com ([66.122.195.4]:33037 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261625AbVAGVcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:32:51 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291332@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 13:44:19 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you consider to use c->x86_apicid to get phy_proc_id, that is initial
apicid.?

YH


4407.29 BogoMIPS (lpj=2203648)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 7 -> Node 3
phy_proc_id[0] = 0
phy_proc_id[1] = 0
phy_proc_id[2] = 9
phy_proc_id[3] = 9
phy_proc_id[4] = 10
phy_proc_id[5] = 10
phy_proc_id[6] = 11
phy_proc_id[7] = 11
CPU: Physical Processor ID: 11
 stepping 00
Total of 8 processors activated (35209.21 BogoMIPS).

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 1:12 PM
To: YhLu
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
> After keep the bsp using 0, the jiffies works well. Werid?

Probably a bug somewhere.  But since BSP should be always 
0 I'm not sure it is worth tracking down.

-Andi
