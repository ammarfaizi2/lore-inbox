Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVAGVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVAGVEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVAGVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:03:39 -0500
Received: from mail.tyan.com ([66.122.195.4]:33544 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261603AbVAGVC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:02:57 -0500
Message-ID: <3174569B9743D511922F00A0C94314230729132B@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 13:14:24 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After keep the bsp using 0, the jiffies works well. Werid?

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 11:41 AM
To: YhLu
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Fri, Jan 07, 2005 at 11:43:52AM -0800, YhLu wrote:
> Amd 8111 and 8131 only have 4 bit for apcid. So it only can use 0-15.

How broken. Ok. But I still don't like your patch. You should
give the BSP ID 0 and for the others it shouldn't matter anyways
if they use high APICIDs. 

-Andi
