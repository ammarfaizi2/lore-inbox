Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVBOPlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVBOPlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVBOPlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:41:37 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:6302 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261759AbVBOPld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:41:33 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Lorenzo Colitti <lorenzo@colitti.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <4211E729.1090305@colitti.com>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <200502150605.11683.s0348365@sms.ed.ac.uk>  <4211E729.1090305@colitti.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 15:41:23 +0000
Message-Id: <1108482083.12031.10.camel@elrond.flymine.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 13:12 +0100, Lorenzo Colitti wrote:

> I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2 
> patch). However, I need to use acpi_sleep=s3_bios, and I can't use 
> radeonfb or it will lock up on resume.

Could you grab dmidecode from http://www.nongnu.org/dmidecode/ and
provide the output? It'd be interesting to compare working with
non-working machines. It might also be good to see lspci and acpidmp
output.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

