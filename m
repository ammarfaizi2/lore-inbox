Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWAIE0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAIE0k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWAIE0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:26:40 -0500
Received: from mxsf07.cluster1.charter.net ([209.225.28.207]:51886 "EHLO
	mxsf07.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751247AbWAIE0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:26:39 -0500
X-IronPort-AV: i="3.99,345,1131339600"; 
   d="scan'208"; a="1175312833:sNHT28978232"
Subject: 64 bit kernel
From: Stan Gammons <s_gammons@charter.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 22:27:15 -0600
Message-Id: <1136780835.6695.37.camel@falklands.home.pc>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I was wondering if anyone can tell me if the following is a 64 bit
kernel problem or if it's a BIOS problem.

I have a Gigabyte K8NSC-939 with an AMD64 3200+ (Venice) CPU version F7
BIOS. When I first got this board, I put a single 512 Mb PC2700 DIMM in
it from an older Celeron board I had. 32 bit Suse 10.0 and 32 bit FC4
loaded fine. When I tried the 64 bit version of either, I kept getting
DMA errors on boot like the HD or controller was bad. After some
searching I found others with similar problems and they had to use
"noapic nolapic" kernel boot options to install and boot the OS. That
worked for me too and I was able to install the OS.

After I upgraded the memory and put 2 512Mb PC3200 DIMMS in the board. I
tried a 64 bit install again. This time I no longer had to use the
"noapic nolapic" options. With a single DIMM, BIOS (during boot)
reported "single channel" memory. With 2 DIMMS, BIOS (during boot)
reports "dual channel" memory. My question though is does the 64 bit
kernel require "dual channel" memory or is this a BIOS problem?  



Stan


