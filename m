Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTETAoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTETAoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:44:18 -0400
Received: from mail148.mail.bellsouth.net ([205.152.58.108]:50279 "EHLO
	imf62bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S263365AbTETAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:44:06 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Machin dependent serial port patches
Date: Mon, 19 May 2003 20:56:00 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305192056.00610.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	One of the things I noticed in the port of 2.5.69 to the 386EX embedded 
system is that serial.h appears to not be a mach-xxx positionable file.  The 
386EX board uses standard 8250 type serial ports, but at 3.6864Mhz instad of 
1.8432Mhz.  There appears to be no way to build a patch set without modifying 
include/i386/serial.h.  Would this not be better places in mach-defaults?  
I'm trying very hard to modify as few files as possible when building these 
patch sets.

	--John
