Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFXNLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 09:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTFXNLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 09:11:12 -0400
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:51110 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id S262000AbTFXNLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 09:11:10 -0400
Message-Id: <sef818ff.059@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Tue, 24 Jun 2003 09:25:11 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <ranma@gmx.at>, <linux-kernel@vger.kernel.org>
Subject: Re: WDC HD found, but ignored?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>> Tobias Diedrich <ranma@gmx.at> 06/23/03 07:14PM >>>
> This is a really weird case.
> The kernel (2.4.21-ac2) finds the hard disk (WDC WD1800JB-00DUA0),
but
> does not attach the ide-disk driver (No error message). The
following
> partition check fails with I/O error on sector 0. Attempts to access
the
> disk (In this case hdc) on the booted system result in the kernel
trying
> to load the ide-disk module, which fails because it is compiled in.
> The works fine in this configuration when booting the W2K partition.

> I hope someone has an idea on what is going wrong here.
> Please CC me on replies as I am not subscribed to the list at the
> moment.
> Kernel boot log:

> Linux version 2.4.21-ac2 (root@elektra) (gcc version 2.95.4 20011002
(Debian prerelease)) #5 Sun Dec 1 18:56:36 CET 2002
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
> BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
> BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> On node 0 totalpages: 229376
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/hda1 vga=ext parport=auto
hdc=ide-scsi

hdc=ide-scsi? Do you really want this?

Nik
