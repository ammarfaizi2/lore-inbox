Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264109AbUCZSkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUCZSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:38:44 -0500
Received: from math.ut.ee ([193.40.5.125]:19963 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264120AbUCZSdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:33:22 -0500
Date: Fri, 26 Mar 2004 20:33:18 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.5-pre* does not boot on my PReP PPC
Message-ID: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
(PReP with no RTAS but with OF).

I use netboot to test new kernels.  Normally, the screen is changed to
VGA text mode and the bootloader speaks some lines of info and asks for
the kernel command line. Now, the image is loaded via tftp (as shown by
tcpdump, the last datagram is smaller) and nothing more happens. The
cursor stays where it is - at the beginning of the Booting ... line in
graphics mode OF environment and that's all.

-- 
Meelis Roos (mroos@linux.ee)

