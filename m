Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVKHJNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVKHJNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKHJNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:13:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40383 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751220AbVKHJNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:13:08 -0500
Date: Tue, 8 Nov 2005 10:12:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, patrizio.bassi@gmail.com
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
Message-ID: <20051108091254.GE15730@elf.ucw.cz>
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz> <1131411772.3003.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131411772.3003.1.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > echo shutdown > /sys/power/disk
> > > echo disk > /sys/power/state
> > > 
> > > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> > >  printing eip:
> > > EIP:    0060:[<c0132a5e>]    Not tainted VLI
> > > EFLAGS: 00010286   (2.6.14-git4)
> > > EIP is at enter_state+0xe/0x90
> > 
> > It works for me, with pretty recent tree. But I see a potential
> > problem there, you are not using ACPI, right?

> It's my bad. Thanks for fixing this, Pavel. Maybe patrizio didn't enable
> ACPI sleep.

Will you take care of pushing that patch to mainline?
								Pavel
-- 
Thanks, Sharp!
