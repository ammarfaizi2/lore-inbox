Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUIUTS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUIUTS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIUTS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:18:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:33496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267973AbUIUTS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:18:27 -0400
Date: Tue, 21 Sep 2004 21:18:27 +0200
From: Andi Kleen <ak@suse.de>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921191826.GF18938@wotan.suse.de>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de> <1095794035.24751.54.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095794035.24751.54.camel@tdi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    All pointers are actually interpreted as offsets into the buffer for
> this interface.  They are not actually pointers.  I believe the 32bit
> emulation problem is limited to an ILP32 application generating data
> structures appropriate for an LP64 kernel.  While difficult, it can be
> done.

If this involves patching the application - no it cannot be done.
The 64bit kernel is supposed to run vanilla 32bit user land.

Please find some other solution for this. An ioctl doesn't sound that bad.

-Andi
