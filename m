Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935833AbWK1KjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935833AbWK1KjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935834AbWK1KjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:39:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64471 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S935833AbWK1KjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:39:07 -0500
Date: Tue, 28 Nov 2006 10:43:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Martin A. Fink" <fink@mpe.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Message-ID: <20061128104351.1bc34eee@localhost.localdomain>
In-Reply-To: <200611281109.47438.fink@mpe.mpg.de>
References: <200611281109.47438.fink@mpe.mpg.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 11:09:47 +0100
"Martin A. Fink" <fink@mpe.mpg.de> wrote:

> Dear Alan,
> 
> You wrote
> > The PIIX interface needs CPU intervention each command, so in practice
> > about every 64K or so, and the CPU gets stalled waiting for the disk
> > during the setup of each I/O. The newer kernels support AHCI which does
> > not have this overhead, but it is only present on the newest intel
> > controllers.
> 
> Can you tell me the name of these newest controllers? Is it ICH7 or 8 ?
> What kernel versions? dmesg only shows ACPI and u/e/o hci_* host controller.
> (kernel version is 2.6.8-24.25-smp). How can I switch to AHCI ?

According to the docs

	ICH6
	ICH6M
	ICH7
	ICH7M
	ICH7R
	ESB2
	ICH7-M DH
	ICH8
	ICH8M

These devices support both "legacy" and "ahci" modes of operation,
usually controlled by a BIOS setting.
