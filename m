Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWBBBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWBBBaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWBBBaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:30:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:39614 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422653AbWBBBaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:30:20 -0500
Date: Wed, 1 Feb 2006 19:21:28 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: alan@lxorguk.ukuu.org.uk
cc: rmk+kernel@arm.linux.org.uk, <linux-kernel@vger.kernel.org>
Subject: 8250 serial console fixes -- issue
Message-ID: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an issue for me an embedded PowerPC SoC using the 
8250 driver.

The simple description of my issue is this:  I'm using the serial port for
both a terminal and console.  I run fdisk on a /dev/hda.  Before this
patch I would get the prompt for fdisk immediately.  After this patch I
have to hit return before the prompt is displayed.

I know that's not a lot of info, but just let me know what else you need 
to help debug this.

I'm guessing something about the UARTs on the PowerPC maybe bit a little 
non-standard.

thanks

- kumar

