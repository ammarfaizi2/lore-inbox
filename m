Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132504AbQK3BEt>; Wed, 29 Nov 2000 20:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132489AbQK3BEL>; Wed, 29 Nov 2000 20:04:11 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:17191 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S132428AbQK3BDi>; Wed, 29 Nov 2000 20:03:38 -0500
Message-ID: <3A255FB2.C54F82D8@linux.com>
Date: Wed, 29 Nov 2000 11:57:39 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [bug] apm resume, uhci and usb devices won't talk right anymore
Content-Type: multipart/mixed;
 boundary="------------16442DD0A1E888A868C76B6E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------16442DD0A1E888A868C76B6E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

usb-uhci.c: interrupt, status 2, frame# 532
usb-uhci.c: interrupt, status 2, frame# 546
usb.c: USB disconnect on device 6
usb-uhci.c: interrupt, status 2, frame# 569
hub.c: USB new device connect on bus1/1, assigned device number 7
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=7 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 8
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=8 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 9
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=9 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 10
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=10 (error=-110)

upon resume, my pegasus nic won't come back.  none of my usb devices
will work.  i need to reboot before i can use them again.

-d


--------------16442DD0A1E888A868C76B6E
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------16442DD0A1E888A868C76B6E--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
