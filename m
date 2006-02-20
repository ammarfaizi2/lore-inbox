Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWBTSBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWBTSBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWBTSBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:01:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25299 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161087AbWBTSBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:01:08 -0500
Date: Mon, 20 Feb 2006 19:01:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ian Kent <raven@themaw.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: autofs kconfig text misleading
Message-ID: <Pine.LNX.4.61.0602201859160.24598@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


currently (2.6.16-rc1 and possible -rcX), the Kconfig help text for autofs4 
reads as follows:

    The automounter is a tool to automatically mount remote file
    systems on demand. This implementation is partially kernel-based to
    reduce overhead in the already-mounted case; this is unlike the BSD
    automounter (amd), which is a pure user space daemon.

But obviously I can use autofs4 with local filesystems,
that is, CDROM, too.



Jan Engelhardt
-- 
