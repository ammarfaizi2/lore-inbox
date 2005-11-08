Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVKHAvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVKHAvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVKHAvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:51:04 -0500
Received: from fmr17.intel.com ([134.134.136.16]:33471 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030211AbVKHAvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:51:01 -0500
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
From: Shaohua Li <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, patrizio.bassi@gmail.com
In-Reply-To: <20051107164715.GA1534@elf.ucw.cz>
References: <20051006072749.GA2393@spitz.ucw.cz>
	 <20051107164715.GA1534@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 09:02:52 +0800
Message-Id: <1131411772.3003.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 17:47 +0100, Pavel Machek wrote:
> Hi!
> 
> > echo shutdown > /sys/power/disk
> > echo disk > /sys/power/state
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> >  printing eip:
> > EIP:    0060:[<c0132a5e>]    Not tainted VLI
> > EFLAGS: 00010286   (2.6.14-git4)
> > EIP is at enter_state+0xe/0x90
> 
> It works for me, with pretty recent tree. But I see a potential
> problem there, you are not using ACPI, right?
> 
It's my bad. Thanks for fixing this, Pavel. Maybe patrizio didn't enable
ACPI sleep.

Thanks,
Shaohua

