Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268044AbTGLRlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbTGLRlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:41:55 -0400
Received: from port-212-202-177-10.reverse.qdsl-home.de ([212.202.177.10]:8251
	"EHLO camelot.fbunet.de") by vger.kernel.org with ESMTP
	id S268044AbTGLRl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:41:29 -0400
From: Fridtjof Busse <fridtjof.busse@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.22-pre5] usb-storage error
Date: Sat, 12 Jul 2003 19:56:12 +0200
X-OS: Linux on i686
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121956.12642@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I'm trying to backup files from an ext3-partition via dump. The 
backup-drive is an USB 2.0 disk.
After a few minutes I get an error (with -pre3 to -pre5):

kernel: usb_control/bulk_msg: timeout
kernel: usb_control/bulk_msg: timeout
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB disconnect on device 00:02.2-1 address
2
kernel: usb-storage: host_reset() requested but not implem
ented
kernel: scsi: device set offline - command error recover f
ailed: host 1 channel 0 id 0 lun 0
kernel: SCSI disk error : host 1 channel 0 id 0 lun 0 retu
rn code = 6050000
kernel:  I/O error: dev 08:01, sector 46990

The same procedure works fine with 2.4.21, so I guess there's a problem 
with the new USB-code (2.4.21-ac4 doesn't work also, a bug in ehci 
kills the entire machine with an "Oops").

Please CC me, thanks.

-- 
Fridtjof Busse
	"Life and death are seldom logical."
	"But attaining a desired goal always is."
		-- McCoy and Spock, "The Galileo Seven", stardate 2821.7

