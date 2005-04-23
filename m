Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVDWJKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVDWJKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDWJKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 05:10:10 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:64970 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261507AbVDWJKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 05:10:06 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
From: Alexander Nyberg <alexn@dsv.su.se>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE74270013E8B96@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE74270013E8B96@pdsmsx402.ccr.corp.intel.com>
Content-Type: text/plain
Date: Sat, 23 Apr 2005 11:10:03 +0200
Message-Id: <1114247403.916.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PPC64 IA64 and S390 use variable size TASK_SIZE for 32 bit and 64 bit
> program.
> I feel it is hard to maintain if we try to audit TASK_SIZE use
> everywhere, because most of them are in generic code.
> 
> And maintaining those audit code in separate place is also a problem.
> E.g. in current 32 bit emulation code
> TASK_SIZE is defined as 0xfffffff in elf loading, but defined as
> 0xffffe000 in mmaping.
> 
> How did that earlier patch break applications?

http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/1605.html

I never investigated specifically what broke down

