Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTE0Frm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTE0Frm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:47:42 -0400
Received: from [164.164.89.245] ([164.164.89.245]:64015 "EHLO
	snblrm01.scandentgroup.com") by vger.kernel.org with ESMTP
	id S262185AbTE0Frk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:47:40 -0400
Subject: Re: [bug] 2.5.68: USB
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF2A9B6A94.2AB03675-ON65256D33.00210116@scandentgroup.com>
From: satyakumar.y@scandentgroup.com
Date: Tue, 27 May 2003 11:33:35 +0530
X-MIMETrack: Serialize by Router on snblrm01/Scandent(Release 5.0.8 |June 18, 2001) at
 05/27/2003 11:33:44 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=65256D33002101168f9e8a93df938690918c65256D3300210116"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=65256D33002101168f9e8a93df938690918c65256D3300210116
Content-type: text/plain; charset=us-ascii



recompile the kernel   selecting the
usb device  file system   option    in   usb support





                                                                                                                             
                    Nico Schottelius                                                                                         
                    <schottelius@wdt.de>           To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>          
                    Sent by:                       cc:                                                                       
                    linux-kernel-owner@vger.       Subject:     [bug] 2.5.68: USB                                            
                    kernel.org                                                                                               
                                                                                                                             
                                                                                                                             
                    05/26/2003 07:11 PM                                                                                      
                                                                                                                             
                                                                                                                             




Hello!

When attaching usb devices to my box, no new entries in /dev/ are
created (tried with usbstick, harddisk in a box)..so I can't acces any
of them!

------------------
flapp:/usr # lsmod
Module                  Size  Used by
usb_storage            99536  0
scsi_mod               48132  1 usb_storage
ohci_hcd               13152  0
usbcore                73436  4 usb_storage,ohci_hcd
...

flapp:/usr # ls /dev/usb/
.  ..
flapp:/usr # ls /dev/scsi/
.  ..

flapp:/usr # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HITACHI_ Model: DK23AA-12        Rev: 0811
  Type:   Direct-Access                    ANSI SCSI revision: 02

(which is the usb harddisk)

Or do I have to load the scsi disk driver ?

Nico

--
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt
mails
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)
(See attached file: attkklzr.dat)


--0__=65256D33002101168f9e8a93df938690918c65256D3300210116
Content-type: application/octet-stream; 
	name="attkklzr.dat"
Content-Disposition: attachment; filename="attkklzr.dat"
Content-transfer-encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYxLjAuNyAoR05V
L0xpbnV4KQ0KDQppRDhEQlFFKzBobDh0bmxVZ2dMSnNYMFJBdG9iQUo5ekY1d2NjUmNRNXppUEdN
bCtPc29lVks3Mit3Q2RFYjhHDQpLUEpYS2RXR3NLc094ZjZLRXFLRkFxbz0NCj0xWkF6DQotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

--0__=65256D33002101168f9e8a93df938690918c65256D3300210116--

