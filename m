Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTG1Kd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTG1Kd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:33:27 -0400
Received: from foo.gazonk.org ([213.212.13.120]:61610 "HELO gazonk.org")
	by vger.kernel.org with SMTP id S265922AbTG1Kd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:33:27 -0400
Date: Mon, 28 Jul 2003 12:48:41 +0200 (CEST)
From: Jonas Bofjall <j-lnxk@gazonk.org>
X-X-Sender: jonas@gazonk.org
To: linux-kernel@vger.kernel.org
Subject: Broadcom 5702 not working in 2.6.0-test2
Message-ID: <Pine.LNX.4.51.0307281241110.29434@gazonk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The A7V8X Deluxe motherboard has an integrated Broadcom 5702 controller.
It works using the bcm5700 driver available for the 2.4 kernels, however
that driver has some drawbacks (for example it initializes itself with a
fixed IP address). The tg3 driver has been mentioned here as its
replacement in 2.6. This driver can't find the MAC address of the
interface and aborts.

Has anyone got this ethernet interface working with the 2.6 drivers?
