Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVC3GJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVC3GJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVC3GJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:09:46 -0500
Received: from fmr20.intel.com ([134.134.136.19]:21484 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261633AbVC3GJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:09:22 -0500
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
Organization: Intel
To: acpi-devel@lists.sourceforge.net, <romano@dea.icai.upco.es>
Subject: Re: [ACPI] Re: [BKPATCH] ACPI for 2.6.12-rc1
Date: Wed, 30 Mar 2005 14:09:00 +0800
User-Agent: KMail/1.6.1
Cc: "Andrew Morton" <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       <linux-kernel@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>
References: <1111127024.9332.157.camel@d845pe> <20050319215239.GA5105@rukbat.dea.icai.upco.es> <20050329081321.GA4133@pern.dea.icai.upco.es>
In-Reply-To: <20050329081321.GA4133@pern.dea.icai.upco.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Message-Id: <200503301409.00785.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 16:13, Romano Giannetti wrote:
>  This is to report an issue with 2.6.11 and ACPI battery/ac. The resume is:
>  acpi battery with preemptive kernel do not work, while the same kernel
> with no preempt works ok. I have tried to collect all the possible info;
> tell me if you need something more.
>
>  The details:
>
>  The working kernel is 2.6.11 with the patch from the acpi-devel list to
> fix acpi keys (not working otherwise). See for a description
>  http://bugme.osdl.org/show_bug.cgi?id=4124

If you can find AE_AML_BUFFER_LIMIT in your long, then, it should be 
interpreter bug.  please see http://bugzilla.kernel.org/show_bug.cgi?id=4150
Otherwise, maybe it is related to EC driver.
-- 
Thanks,
Luming
