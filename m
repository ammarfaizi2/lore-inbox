Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263278AbTJKMBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTJKMBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:01:33 -0400
Received: from [202.149.212.34] ([202.149.212.34]:20835 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id S263278AbTJKMBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:01:30 -0400
Date: Sat, 11 Oct 2003 17:31:08 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@venus.cmie.ernet.in>
To: <linux-kernel@vger.kernel.org>
cc: <smartmontools-support@lists.sourceforge.net>
Subject: Reproducable time problem with SMARTD & XNTPD
Message-ID: <Pine.LNX.4.33.0310111545530.1047-100000@venus.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We have a Intel 875WP1-E motherboard with 2 onboard SATA ports.
In addition to the two 80GB SATA disks attached to these ports we
have three 160GB IDE HDD and one 300GB IDE HDD attached to 2 Promise
controllers (PDC20269). The server has xntpd configured on it to sync
time from remote timeserver. It has been running without any problems
for more than 2 months.

Last week we installed SMARTD on this box. SMARTD was configured to
monitor the 6 HDDs. The time on the server started to go out of sync
with the remote time server. And the difference increases over time.
As soon as smartd daemon was shut XNTPD started to get the server time in
sync slowly.  We tried this 2-3 times and have noticed the same results.

Has anyone faced a similar problem ?

Nohez


Linux Distro: SuSE Linux 8.2 Professional
Kernel      : k_smp-2.4.21-108 (SMP because of Hyper-threading)
XNTPD       : xntp-4.1.1-177
SMARTD      : smartmontools-5.1.4-20

