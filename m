Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVAGTkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVAGTkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAGTga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:36:30 -0500
Received: from mail.tyan.com ([66.122.195.4]:64265 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261545AbVAGTcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:32:18 -0500
Message-ID: <3174569B9743D511922F00A0C94314230729131E@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 11:43:52 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amd 8111 and 8131 only have 4 bit for apcid. So it only can use 0-15.

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 11:29 AM
To: YhLu
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

> Without subtract boot_cpu_id, phys_pkg_id will return 8.
> With that, It will return 0.

Normally this is set up that the CPUs come first and then the IO-APICs.
Why is this not possible with 8111 and 8131?

-Andi
