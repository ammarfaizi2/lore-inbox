Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264644AbVBECFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264644AbVBECFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbVBECFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:05:48 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:2480 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S264644AbVBECFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:05:32 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910502040931955f5a6@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
Date: Sat, 05 Feb 2005 02:04:49 +0000
Message-Id: <1107569089.8575.35.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 12:31 -0500, Jon Smirl wrote:

> Fixing this at kernel boot (resume) time will let user space apps
> assume that all video cards are reset. That removes a lot of
> complexity from the user space apps (like X).

This can't be the default on x86. I have hardware that will die if you
attempt to POST it after the BIOS has started the OS. Non-x86 should be
fine, though.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

