Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbSKOQl7>; Fri, 15 Nov 2002 11:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbSKOQl6>; Fri, 15 Nov 2002 11:41:58 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:30472 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266409AbSKOQl6>; Fri, 15 Nov 2002 11:41:58 -0500
Message-ID: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
Date: Fri, 15 Nov 2002 11:42:07 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: CD IO error
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I've been getting these messages since about 2.5.45.  I can't mount any
cds at all.  Elvtune (util-linux-2.11r) also fails on /dev/hda which I'm
running on, and /dev/hdc, my cdrom.

Any further info needed?

-alan

end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0

# hdparm /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device



