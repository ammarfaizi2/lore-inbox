Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVBGNZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVBGNZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 08:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBGNZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 08:25:41 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:5316 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261228AbVBGNZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 08:25:37 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107695583.14847.167.camel@localhost.localdomain>
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
	 <1107695583.14847.167.camel@localhost.localdomain>
Date: Mon, 07 Feb 2005 13:24:56 +0000
Message-Id: <1107782696.8575.72.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume (was: Re:
	[ACPI] Samsung P35, S3, black screen (radeon))
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 16:02 +0000, Alan Cox wrote:

> Some systems (intel notably) appear to expect you to use the bios
> save/restore video state not re-POST.

This works well in many cases, but there are some machines that freeze
if you attempt to make a VBE state save call. Sadly, I don't have any
access to an affected machine, so it's a bit awkward working out what
the problem is.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

