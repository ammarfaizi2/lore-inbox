Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVIFLyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVIFLyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVIFLyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:04 -0400
Received: from tim.rpsys.net ([194.106.48.114]:61591 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964824AbVIFLyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:03 -0400
Subject: [-mm patch 0/5] SharpSL: Prepare drivers and add new ARM PXA
	machines Spitz and Borzoi
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:45 +0100
Message-Id: <1126007626.8338.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sharp's newer range of Zaurus clamshell handhelds, the cxx00's are
similar to the c7x0 series yet different. This patch series abstracts
the differences and generates a set of common drivers that support both
series of devices. It then adds machine support for Spitz (SL-C3000) and
Borzoi (SL-C3100). Hooks for Akita (SL-C1000) differences are also
added. The I2C driver for its IO expander is the only missing piece.

This series of patches is heavily based on the corgi patches already in
-mm so its being submitted to Andrew. The patches have been mentioned on
linux-arm-kernel and no objections were raised.

I hope to follow this series with a spitz keyboard driver (the only
driver not shared with the c7x0) and a battery+power management driver
for both corgi and spitz models within a few days.

USB Host and MTD support for Spitz are being dealt with through the
subsystem maintainers.

Richard




