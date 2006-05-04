Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWEDOmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWEDOmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEDOmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:42:10 -0400
Received: from smtpauth00.csee.siteprotect.com ([64.41.126.131]:44493 "EHLO
	smtpauth00.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S1750737AbWEDOmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:42:09 -0400
From: "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
To: "'Erik Mouw'" <erik@harddisk-recovery.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Generic SATA driver which works with Marvell SATA
Date: Thu, 4 May 2006 19:33:45 +0530
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAo6BlOIGRPESYDOrUYkqB1gEAAAAA@spsoftindia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcZvfCe9bLJW5fvSQwmGx/J5XirgnwAAxO5A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20060504130822.GB16570@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

Even I tried loading sd_mod scsi disk driver; I am not able to see any SATA
disks.

When I cat /proc/scsi/scsi it shows:
 
Attached devices:

I believe there must be some low level driver for the SATA devices (eg:
mv_sata for Marvel SATA) which allows sd_mod to expose them as a scsi
devices?

I need a generic SATA driver to be used as replace of (eg: mv_sata) driver.

Please suggest.

Yogesh



-----Original Message-----
From: Erik Mouw [mailto:erik@zurix.bitwizard.nl] On Behalf Of Erik Mouw
Sent: Thursday, May 04, 2006 6:38 PM
To: Yogesh Pahilwan
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic SATA driver which works with Marvell SATA

On Thu, May 04, 2006 at 06:29:04PM +0530, Yogesh Pahilwan wrote:
> Is there any generic SATA driver available which should work with Marvell
> SATA disks? 

If the disk behaves like a standard SATA disk the sd driver should work
just fine (like with any other SATA disk).

> Where can I download this driver?

It comes free with your kernel source.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

