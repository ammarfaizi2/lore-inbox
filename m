Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272738AbTHKRKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272910AbTHKRIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:08:13 -0400
Received: from mail.convergence.de ([212.84.236.4]:41419 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S272840AbTHKREv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:04:51 -0400
Date: Mon, 11 Aug 2003 19:04:48 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: IDE Hotswap Disks
Message-ID: <20030811170448.GC732@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Flameeyes <dgp85@users.sourceforge.net>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <1060615212.13982.15.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060615212.13982.15.camel@defiant.flameeyes>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 05:20:13PM +0200, Flameeyes wrote:
> I've a rack for ide HDDs that claims to be hotswappable, in fact, I'm
> able to remove the disk without problems after unmount it.
> The problem is when I try to connect it after booting without it. The
> only way I have is rebooting (also with warm reboot) the machine, and
> then the kernel rescan the bus and see the new drive.
> I tried hdparm -R /dev/hdb (i'm using devfs, but also create the block
> device 0 64 do nothing), but it gave me "expected hwif_ctrl".
> There's a way to rescan the bus without reboot? I need to try with
> ide-scsi support?

The hdparm package includes a script which does that (idectl).
I used it sporadically with a Thinpad Ultrabay IDE disk and cdrom.


Johannes
