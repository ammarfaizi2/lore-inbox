Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272274AbTHIHtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272278AbTHIHtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:49:15 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:1920
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S272274AbTHIHtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:49:14 -0400
Message-Id: <200308090749.h797n15Y001167@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: Linux 2.6.0-test3: USB still broken.
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Fri, 08 Aug 2003 22:40:37 PDT." <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Aug 2003 01:49:01 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The USB subsystem is still broken in test3.
everything seems to build w/o errors, but late in the boot the screen
is filled with the line

	drivers/usb/input/hid-core.c: control queue full

which repeats a a high rate and is VERY hard to break free from.
Not good.
-- 
                                        Reg.Clemens
                                        reg@dwf.com


