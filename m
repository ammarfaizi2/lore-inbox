Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUJJTV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUJJTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUJJTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 15:21:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19135 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268447AbUJJTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 15:21:58 -0400
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for
	2.4.28-pre3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martins Krikis <mkrikis@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
In-Reply-To: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
References: <20041009204425.49483.qmail@web13725.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097432347.29422.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 10 Oct 2004 19:19:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-09 at 21:44, Martins Krikis wrote:
> It is an ataraid "subdriver" but uses the SCSI subsystem to find the
> RAID member disks. It depends on the libata library, particularly the
> ata_piix driver that enables the Serial ATA capabilities in ICH5/ICH6
> chipsets. Hence, for kernels older than 2.4.28, the libata patch by 
> Jeff Garzik should be applied before applying this patch.

This seems to make sense to me - for 2.6 we have the DM layer, for 2.4
we've used the ataraid stuff.


