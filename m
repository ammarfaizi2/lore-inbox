Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVA3Qoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVA3Qoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVA3Qoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:44:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42447 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261723AbVA3Qo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:44:27 -0500
Subject: Re: Flashing BIOS of a PCI IDE card (IT8212F)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rahul Karnik <deathdruid@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5b64f7f050127081948af7a31@mail.gmail.com>
References: <5b64f7f050127081948af7a31@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106844207.14787.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 30 Jan 2005 15:39:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-27 at 16:19, Rahul Karnik wrote:
> card from within Linux. I have an OEM IT8212 card with a really old
> BIOS which the vendor does not support with a BIOS flashing tool. ITE
> Tech's flashing tool appears to work, but it fails to verify that the
> flash was successful and indeed the ROM is unchanged.

Not every vendor bothers to make the flash writable from the PCI card,
and if the ROM is unchanged that seems likely.

Note that with the 2.6.10-ac kernels if you have a BIOS in raid mode you
can force it out of raid mode with a boot option. You cannot however do
the same in the other direction.

