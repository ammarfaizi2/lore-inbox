Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUIWR4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUIWR4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUIWR4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:56:20 -0400
Received: from symbion.srrc.usda.gov ([199.133.86.40]:15276 "EHLO
	node1.cluster.srrc.usda.gov") by vger.kernel.org with ESMTP
	id S268207AbUIWRz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:55:29 -0400
Subject: RE: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
From: Glenn Johnson <gjohnson@srrc.ars.usda.gov>
To: Adam Radford <aradford@amcc.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <I4I8RQ00.F30@hadar.amcc.com>
References: <I4I8RQ00.F30@hadar.amcc.com>
Content-Type: text/plain
Organization: USDA, ARS, SRRC
Message-Id: <1095962127.4467.10.camel@node1.cluster.srrc.usda.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 12:55:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 12:32, Adam Radford wrote:

> Glenn,
> 
> The /proc/scsi interface is being deprecated by the SCSI subsystem maintainers.

I am aware of that.  I also thought the interface would remain until
third party vendors had a chance to catch up.

> Support for /proc/scsi/3w-xxxx has been removed from the driver and sysfs support
> has been added. 

Is is possible to have it support both?

> Please download the newer 3dm2 tools from the 3ware software
> "In-Engineering Development" website, or, keep your older kernel and tools.

I am not sure what the "In-Engineering Development" website is but the
"regular" 3ware Web site only offers 3dm2 for the 9000 series
controllers, which I do not have.  I suppose I could just try it though.
  
> If you have any more questions, please contact 3ware/AMCC support.

I do not know what AMCC brings to the table but I have never gotten
answers from 3Ware support.

> -Adam
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Glenn Johnson
> Sent: Thursday, September 23, 2004 9:09 AM
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
> 
> 
> I have a 3Ware-7500 series card.  I was trying the 2.6.9-rc2-mm2 kernel
> and discovered that the 3dmd utility was not working.  A little poking
> around revealed that the cause was because the 3Ware directory was not
> in /proc/scsi, even though I have CONFIG_SCSI_PROC_FS=y in my config
> file.  The 3dmd utility works fine with mainline 2.6.9-rc2 and it worked
> with the 2.6.8-mm series of kernels.  Those kernels have a 3w-xxxx
> directory in /proc/scsi.
> 
> Thanks.
-- 
Glenn Johnson

