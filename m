Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTAYSWp>; Sat, 25 Jan 2003 13:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTAYSWp>; Sat, 25 Jan 2003 13:22:45 -0500
Received: from CPEdeadbeef0000-CM3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:9476
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261721AbTAYSWo>; Sat, 25 Jan 2003 13:22:44 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sat, 25 Jan 2003 13:32:17 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PROBLEM][2.5.xx] - end_request errors when detecting CD/DVD ROM devices
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200301251332.17137.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is an error or not, but the drives are being 'accessed' 
as soon as they are detected. Is this correct behaviour?

...
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
....
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
