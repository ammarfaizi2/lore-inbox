Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272705AbTHKPTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272712AbTHKPTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:19:32 -0400
Received: from smtp0.libero.it ([193.70.192.33]:24537 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S272705AbTHKPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:19:31 -0400
Subject: IDE Hotswap Disks
From: Flameeyes <dgp85@users.sourceforge.net>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060615212.13982.15.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 17:20:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've a rack for ide HDDs that claims to be hotswappable, in fact, I'm
able to remove the disk without problems after unmount it.
The problem is when I try to connect it after booting without it. The
only way I have is rebooting (also with warm reboot) the machine, and
then the kernel rescan the bus and see the new drive.
I tried hdparm -R /dev/hdb (i'm using devfs, but also create the block
device 0 64 do nothing), but it gave me "expected hwif_ctrl".
There's a way to rescan the bus without reboot? I need to try with
ide-scsi support?

TIA.
-- 
Flameeyes <dgp85@users.sf.net>

