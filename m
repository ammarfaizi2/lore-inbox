Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUATMkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUATMkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:40:11 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:55766 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265471AbUATMkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:40:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 20 Jan 2004 13:46:26 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] -mm5 has no i2c on amd64
Message-ID: <20040120124626.GA20023@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

trivial fix ...

  Gerd

==============================[ cut here ]==============================
--- linux-mm5-2.6.1/arch/x86_64/Kconfig.i2c	2004-01-20 13:14:42.000000000 +0100
+++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
@@ -429,6 +429,8 @@
 
 source "drivers/char/Kconfig"
 
+source "drivers/i2c/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
