Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRKPIDp>; Fri, 16 Nov 2001 03:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKPIDf>; Fri, 16 Nov 2001 03:03:35 -0500
Received: from ns.muni.cz ([147.251.4.33]:7863 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S281228AbRKPIDZ>;
	Fri, 16 Nov 2001 03:03:25 -0500
Date: Fri, 16 Nov 2001 09:03:22 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: VM tuning for Linux routers
Message-ID: <20011116090322.G20714@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I have a dual Athlon w/ 512M RAM and three NICs (one gigabit
3c985B running 802.1Q with 5 VLANs, two on-board 100Mbit 3c982). This box
has almost nothing other to do apart from routing and packet filtering.
Is there anything I can do to tell the VM system to use as much memory
for network packets as possible?

	I haven't got time to measure the throughput at gigabit speeds
yet,  but I wonder if there is a way to tell the kernel "this box does
routing/firewalling, and almost nothing else".

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
               #include <stdio.h>
               int main(void) { printf("\t\b\b"); return 0; }
