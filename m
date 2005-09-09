Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVIIRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVIIRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVIIRQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:16:26 -0400
Received: from tim.rpsys.net ([194.106.48.114]:41392 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030272AbVIIRQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:16:01 -0400
Subject: [-mm patch 0/6] SharpSL: Prepare drivers and add new ARM PXA
	machines Spitz and Borzoi
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 18:15:33 +0100
Message-Id: <1126286133.8383.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of this patch series. I've taken on board the comments
Russell made and Nish Aravamudan's comment about the use of HZ. I've
also tidied up the couple of coding style and white space issues that
crept in.

Also included this time is the spitz keyboard driver. Its the same
format as corgikbd, although the differences between the hardware make a
common driver impractical/inefficient.

[Summary from last time]:

Sharp's newer range of Zaurus clamshell handhelds, the cxx00's are
similar to the c7x0 series yet different. This patch series abstracts
the differences and generates a set of common drivers that support both
series of devices. It then adds machine support for Spitz (SL-C3000) and
Borzoi (SL-C3100). Hooks for Akita (SL-C1000) differences are also
added. The I2C driver for its IO expander is the only missing piece.

Richard

