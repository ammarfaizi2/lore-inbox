Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVDKUQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVDKUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVDKUQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:16:25 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:34002 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261914AbVDKUOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:14:35 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Pavel Machek <pavel@ucw.cz>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050411200341.39635.qmail@web88008.mail.re2.yahoo.com>
References: <20050411200341.39635.qmail@web88008.mail.re2.yahoo.com>
Date: Mon, 11 Apr 2005 21:14:52 +0100
Message-Id: <1113250492.10110.54.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay
	light in S3 mode stays on
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 16:03 -0400, Shawn Starr wrote:
> I notice in Linux and in XP the drive bay light
> remains on while the laptop is in suspend-to-RAM. I
> know the ACPI  thinkpad extras added to the kernel
> recently can turn this off. I wonder if we can/or need
> to write hooks to turn the light off so to conserve
> power when we're in S3

Just disable it in your suspend script. There's no reason to push that
sort of policy into the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

