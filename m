Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUFDPsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUFDPsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUFDPsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:48:55 -0400
Received: from [82.228.82.76] ([82.228.82.76]:15866 "EHLO
	paperstreet.colino.net") by vger.kernel.org with ESMTP
	id S265828AbUFDPsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:48:47 -0400
Date: Fri, 4 Jun 2004 17:48:18 +0200
From: Colin Leroy <colin@colino.net>
To: Michel <daenzer@debian.org>, Benjamin <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2: no more AGP?
Message-Id: <20040604174818.03a4f795@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.10claws67.4 (GTK+ 2.4.0; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a lousy bugreport... I noticed that agpgart doesn't work anymore on
2.6.7-rc2. Xorg reports that AGP isn't supported, and dmesg doesn't show
the
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode

It only shows
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth 2 chipset
agpgart: Maximum main memory to use for agp memory: 565M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0

Using 2.6.6, it works fine. 

hth,
-- 
Colin
