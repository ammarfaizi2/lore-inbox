Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTLOAEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLOAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 19:04:42 -0500
Received: from deagol.email.Arizona.EDU ([128.196.133.142]:22660 "EHLO
	smtpgate.email.arizona.edu") by vger.kernel.org with ESMTP
	id S262790AbTLOAEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 19:04:41 -0500
Subject: Strange issue with 2.6.0-test11 and magic packets
From: Harry McGregor <hmcgregor@espri.arizona.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Tucson Center Support Group - USGS
Message-Id: <1071446598.30538.6.camel@Sony>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 17:03:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have been having a strange issue while testing 2.6.0-test in one of
our computer labs (actually, it's a Debian GNU/Linux based lab in an
Elementary School!).  The lab uses ether-wake to boot the computers,
which is of course a bios level thing, and works quite nicely.

The problem comes into play that when a computer happens to already be
booted when a magic packet is sent to it's MAC address, CPU load goes to
100%.  top shows the usages as being [events].  We did not experience
this result of sending a magic packet while running 2.4.x kernels.

Hardware is Intel i815e motherboards in Compaq Deskpro systems.  Intel
e100 driver built into the kernel.

If anyone can shed some light on where we should start looking, or any
tests you would like to see done, either follow up this post, or respond
to me directly.

			Harry

