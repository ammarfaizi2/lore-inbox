Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTIJMbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTIJMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:31:22 -0400
Received: from e450.rm.cnr.it ([150.146.1.17]:33471 "EHLO e450.rm.cnr.it")
	by vger.kernel.org with ESMTP id S262881AbTIJMbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:31:13 -0400
Date: Wed, 10 Sep 2003 14:39:58 +0200
From: flavio <flavio.l@tiscali.it>
Subject: PROBLEM:SCSI repeatable 2.4.22 bug
To: linux-kernel@vger.kernel.org
Message-id: <3F5F1B9E.607@tiscali.it>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_mR5m3vLmfSXQq9wZtFDUEw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
 Netscape/7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_mR5m3vLmfSXQq9wZtFDUEw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Hi,

the hd and dvd light are constantly on from boot onwards (using vanilla
2.4.22 and the /var/log/messages is a sequence of messages as in
attachment).
2.4.20 vanilla has no problems whatsoever...


Linux gundam 2.4.22 #5 Sat Sep 6 15:31:04 CEST 2003 i686 unknown unknown 
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.32
pcmcia-cs              3.2.0
quota-tools            3.01.
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         sr_mod tun parport_pc lp parport i810_audio 
ac97_codec soundcore ds yenta_socket pcmcia_core ipt_MASQUERADE 
iptable_nat ipt_state ip_conntrack ipt_LOG iptable_filter ip_tables 
ohci1394 ieee1394 ide-scsi scsi_mod usb-uhci usbcore rtc

it even OOPSED on shutdown:

Unable to handle kernel paging request at virtual address f000ff6b
*pde 00000000
oops 0000
eip 0010:[<d092095a>] Not Tainted
........I took a picture of the screen, if you want I send the 1.2 Mb file..


Plz let me know if I can help somehow..

best regards

Flavio Lombardi

--Boundary_(ID_mR5m3vLmfSXQq9wZtFDUEw)
Content-type: text/plain; name=messages
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=messages

Sep  9 17:46:33 gundam kernel: scsi : aborting command due to timeout : pid 3, scsi0, channel 0, id 0, lun 0 0x43 00 00 00 00 00 00 00 0c 40 
Sep  9 17:46:33 gundam kernel: hdc: lost interrupt
Sep  9 17:46:33 gundam kernel: ide-scsi: The scsi wants to send us more data than expected - discarding data
Sep  9 17:46:33 gundam kernel: ide-scsi: [[ 43 0 0 0 0 0 0 0 c 40 0 0 ]
Sep  9 17:46:33 gundam kernel: ]
Sep  9 17:46:33 gundam kernel: ide-scsi: expected 12 got 24 limit 12
Sep  9 17:46:43 gundam kernel: hdc: lost interrupt
Sep  9 17:46:43 gundam kernel: ide-scsi: The scsi wants to send us more data than expected - discarding data
Sep  9 17:46:43 gundam kernel: ide-scsi: [[ 43 0 0 0 0 0 0 0 c 40 0 0 ]
Sep  9 17:46:43 gundam kernel: ]
Sep  9 17:46:43 gundam kernel: ide-scsi: expected 12 got 24 limit 12
Sep  9 17:46:43 gundam kernel: hdc: lost interrupt
Sep  9 17:46:43 gundam kernel: ide-scsi: The scsi wants to send us more data than expected - discarding data
Sep  9 17:46:43 gundam kernel: ide-scsi: [[ 43 0 0 0 0 0 0 0 c 40 0 0 ]
Sep  9 17:46:43 gundam kernel: ]


--Boundary_(ID_mR5m3vLmfSXQq9wZtFDUEw)--
