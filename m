Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUKWT1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUKWT1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWTZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:25:45 -0500
Received: from fsmlabs.com ([168.103.115.128]:20674 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261519AbUKWTYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:24:35 -0500
Date: Tue, 23 Nov 2004 12:24:31 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
In-Reply-To: <20041122233852.43f93aa9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0411231212140.7167@musoma.fsmlabs.com>
References: <200411230014.15354.gene.heskett@verizon.net>
 <20041122233852.43f93aa9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andrew Morton wrote:

> Gene Heskett <gene.heskett@verizon.net> wrote:
> >
> > Just built bk7 after running the bk4-kjt1 version for a cpouple of 
> >  days, and noticed this in /var/log/dmesg:
> > 
> >  >From grub.conf to dmesg:
> >  Kernel command line: ro root=/dev/hda7 acpi_skip_timer_override
> > 
> >  Then, quite a ways down in that logfile:

I'm input clueless but it looks like it may be getting spurious interrupts 
during the detection phase (is there anything connected?). Gene can you 
reproduce with the 'acpi=off' kernel parameter?

Thanks,
	Zwane
