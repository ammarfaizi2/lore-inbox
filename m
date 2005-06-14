Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVFNIrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVFNIrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 04:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFNIrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 04:47:48 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:10399 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261325AbVFNIrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 04:47:37 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <87ll5diemh.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <87ll5diemh.fsf@www.codersbase.com>
Date: Tue, 14 Jun 2005 09:47:21 +0100
Message-Id: <1118738841.6648.514.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM
	(was: Re: [ACPI] Resume from Suspend to RAM))
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 00:25 -0700, dagit@codersbase.com wrote:

> The reason for (2) is because if I remove the pushl;popl, boot into
> windows suspend/resume, and immeditaly boot into linux then the
> suspend/resume works.  I have screen blanking issues, but I can type
> blindly and the commands all work just fine (I can startx for
> example).

Can you do a lspci -vxxx

a) After a cold boot into linux
b) After a warm boot into linux from Windows

and see if there's any difference between the two?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

