Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbUKPQGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUKPQGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUKPQGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:06:24 -0500
Received: from atarelbas02.hp.com ([156.153.255.213]:43202 "EHLO
	atlrel7.hp.com") by vger.kernel.org with ESMTP id S262015AbUKPQF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:05:27 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: gene.heskett@verizon.net
Subject: Re: Old thread: Nobody cared, chapter 10^3rd
Date: Tue, 16 Nov 2004 09:05:24 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <200411150052.22271.gene.heskett@verizon.net> <1100556963.5875.970.camel@d845pe> <200411152250.25036.gene.heskett@verizon.net>
In-Reply-To: <200411152250.25036.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411160905.24277.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 November 2004 8:50 pm, Gene Heskett wrote:
> On Monday 15 November 2004 17:16, Len Brown wrote:
> >Any difference when you tested with "pci=routeirq"?
> >
> Dunno Len, but I'll add that to grub.conf and reboot for effects. BRB.
> 
> Well, it shut that particular message off, but it sure made ACPI noisy!

I think we're just rediscovering the floppy and i8042 issues that we found
and fixed in -mm a while back.  The i8042 patch is contained in here:

 ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/broken-out/bk-input.patch

I have no idea whether this will apply directly to Linus' kernel, or
whether it depends on other patches, but it should fix the problem.
