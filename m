Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUGIXwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUGIXwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUGIXwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:52:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24565 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265732AbUGIXvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:51:52 -0400
Subject: [RFC]HVCS driver for Linux 2.6 on Power-5
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hollis Blanchard <hollisb@us.ibm.com>,
       Paul Mackerras <paulus@samba.org>, David Boutcher <boutcher@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1089417112.3385.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 18:51:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The following patch, built against linux-2.6.7, includes the driver 
source code, the arch source code (which interacts with firmware and
provides an arch abstracted interface to the driver), and installation
documentation for this driver.

http://www-124.ibm.com/linux/patches/misc/hvcs_to_mainline.diff

This driver implements a virtual console server which provides a tty 
interface for interacting with the virtual consoles of logically
partitioned operating systems on Power-5 hardware from within another
linux partition.  This is required because a physical console adapter
for each partition on a large multi-partition system is impractical.

We would like this patch considered for inclusion into the mainline
2.6 tree.

I'm interested in any comments and critiques.

Thanks,
Ryan S. Arnold


