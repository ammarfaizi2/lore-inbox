Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUDEUxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUDEUxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:53:20 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:29638 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S263058AbUDEUxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:53:17 -0400
Date: Mon, 5 Apr 2004 16:53:16 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Stupid question re: register_cdrom()
Message-ID: <Pine.LNX.4.33L2.0404051649510.16268-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let's say I was coding a cdrom emulator in software for kernel 2.4.  I
am unclear about register_cdrom().  Does register_cdrom() in
cdrom.c take care of telling the kernel that my kdev_t major/minor
combination in fact leads to a real driver?  Or do I need to take care of
that outside of regsiter_cdrom()?

If not.. how do I tell the kernel data structures that my driver's major
number does in fact point to a cdrom driver.  Basically, I want my
driver's major number to show up in /proc/devices..

This might be a stupid question, but I am not a linux kernel expert...

Thanks for your patience!

-Calin

