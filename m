Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTDKXbx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbTDKXbX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:31:23 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:53461 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262662AbTDKX2M convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:28:12 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: USB Keyboard in 2.5 bitkeeper...
Date: Fri, 11 Apr 2003 19:41:08 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304111941.16563.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

input1: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb1:3.0
input2: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb1:3.1

That's only a keyboard, but interestingly it shows up as a keyboard AND mouse.
(This kernel is 2.4.21-pre5-ac3)

Anyway: In 2.5 bitkeeper (4/11/03), my keyboard is completely dead - even 
sysrq doesn't work. I've had similar problems with recent 2.4 bitkeeper 
kernels (but I can't be very specific - I can re-test if you'd like me to)

The keyboard works on 2.4.21-pre5-ac3.

Relevant Config: 
INPUT, SERIO, USB_UHCI_HCD, USB_HID, USB_HIDINPUT = Y

Enabling standard AT keyboard (which shouldn't be necessary) doesn't help.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+l1KbXQ/AjixQzHcRAkjXAKCe+WEJDI5Z4hGHkjU+DZGro0ODOgCfRX9Z
RlEzCaXa1CjiSxG/5avCchI=
=oFCI
-----END PGP SIGNATURE-----

