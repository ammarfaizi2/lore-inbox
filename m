Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbUB1RMw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUB1RMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:12:51 -0500
Received: from maigret.aip.de ([141.33.160.2]:56412 "HELO mail0.aip.de")
	by vger.kernel.org with SMTP id S261879AbUB1RMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:12:42 -0500
Date: Sat, 28 Feb 2004 18:12:39 +0100 (CET)
From: Michael Weber <mweber@aip.de>
X-X-Sender: weber@marsala.aip.de
To: linux-kernel@vger.kernel.org
Subject: Watchdog driver for Rocky 3782 SBC 
Message-ID: <Pine.LNX.4.58.0402281730350.21346@marsala.aip.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have created a simple driver for the watchdog on the Rocky 3782 SBC
boards by digging through the DOS/BIOS routine and comparing that with the
IT8712F data sheet. I have it compiled on 2.4.18--25 kernels.

Anyone interested? Its not tested, because I have no idea how to test it
(I did test if it reboots after x seconds when I don't update the
/proc/watchdog file).

lg,
mweber
