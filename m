Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUFZQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUFZQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUFZQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:40:58 -0400
Received: from sc52-228.softcenter.se ([62.95.52.228]:36821 "EHLO
	irie.2good.net") by vger.kernel.org with ESMTP id S267184AbUFZQk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:40:57 -0400
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
From: David Eriksson <david@2good.nu>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <1088160505.3702.4.camel@tyrosine>
References: <1088160505.3702.4.camel@tyrosine>
Content-Type: text/plain
Message-Id: <1088268145.14987.248.camel@zion.2good.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Jun 2004 18:42:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-25 at 12:48, Matthew Garrett wrote:
> If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
> acpi_sleep=s3_bios passed on the command line). If I have the ioapic
> enabled, however, I get no interrupts after resume. Hacking in a call to
> APIC_init_uniprocessor in the resume path improves things - I get edge
> triggered interrupts, but anything flagged as level triggered doesn't
> work. How can I get the ioapic fully initialised on resume?

Maybe you've found this bug?

http://bugme.osdl.org/show_bug.cgi?id=2643

-- 
-\- David Eriksson -/-                              www.2GooD.nu
 
"I personally refuse to use inferior tools because of ideology."
                                                - Linus Torvalds

