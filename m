Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVA2XlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVA2XlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVA2XlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:41:18 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:36789 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S261604AbVA2XlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:41:07 -0500
Mime-Version: 1.0
Message-Id: <a0620073cbe21c8047634@[129.98.90.227]>
In-Reply-To: <20050129103057.GA27803@hansmi.ch>
References: <a06200736be209a45bd65@[129.98.90.227]>
 <20050129103057.GA27803@hansmi.ch>
Date: Sat, 29 Jan 2005 18:41:19 -0500
To: Michael Hanselmann <hansmi@gentoo.org>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: [gentoo-ppc-dev] CONFIG_THERM_PM72 is missing from .config
 from recent kernels (2.6.10, 2.6.11)
Cc: gentoo-ppc-dev@lists.gentoo.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello Maurice
>
>>  It's missing from .config in at least a few releases of recent
>>  kernels (2.6.10, 2.6.11).
>
>Definitly not true, at least for ppc32.

Note that..

1) I looked only at official kernel source code
and
2) I looked only at a few releases, not every patchset.
and
3) I looked only at the resulting .config file after preparing it 
with make menuconfig.

>Linux g5 2.6.10-gentoo-r6-g5 #6 SMP Wed Jan 26 23:05:05 CET 2005 ppc
>PPC970, altivec supported PowerMac7,2 GNU/Linux

 From what I can tell, the .config file is built up from different 
files. I just looked at gentoo-dev-sources for this version and it 
is, in fact, present for ppc64 in
/usr/src/linux-2.6.10-gentoo-r6/arch/ppc64/defconfig

That suggests the mechanism that generates the .config files is not 
working right under certain circumstances related to the 64bit G5.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
