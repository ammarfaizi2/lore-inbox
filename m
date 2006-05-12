Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWELF1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWELF1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWELF1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:27:38 -0400
Received: from pcsbom.patni.com ([203.124.139.208]:35999 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S1750895AbWELF1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:27:38 -0400
Reply-To: <Chhavi.Agarwal@patni.com>
From: "Chhavi Agarwal" <Chhavi.Agarwal@patni.com>
To: "Linux-Kernel \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: unknown symbol scsi_bus_type
Date: Fri, 12 May 2006 10:59:12 +0530
Message-ID: <015201c67585$012f6020$f4041aac@pcp42816>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1147411744-11195-258"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1147411744-11195-258
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using a linux-2.6.14 kernel.
I am trying to load my iSCSI module but when using insmod the error is

insmod: error inserting 'unh_scsi_target.ko': -1 Unknown symbol in module

linux:/home/chhavi/unh_iscsi.1.6.00/src # dmesg
unh_scsi_target: Unknown symbol scsi_bus_type

I had exported scsi_bus_type and rebuild the kernel.
its seen as exported in module.symvers.

I had used  EXPORT_SYMBOL_GPL() to prevent any license issues.

but still the error persists.

any help will be greatly appreciated.

Thanks




http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1147411744-11195-258--
