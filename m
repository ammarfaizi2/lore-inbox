Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSKCIym>; Sun, 3 Nov 2002 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSKCIym>; Sun, 3 Nov 2002 03:54:42 -0500
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:32777 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261693AbSKCIym>; Sun, 3 Nov 2002 03:54:42 -0500
Date: Sun, 3 Nov 2002 09:05:14 +0100
To: linux-kernel@vger.kernel.org
Subject: Cdrom broken in bk current?
Message-ID: <20021103080514.GC748@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the following during booting:
...
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdd, sector 0
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 16X CD-ROM drive, 256kB Cache, DMA
...

If I mount /dev/hd[cd], the system freezes completly.

This was not present in 2.5.42 IRC
ny help?

