Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSCQKaK>; Sun, 17 Mar 2002 05:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSCQKaB>; Sun, 17 Mar 2002 05:30:01 -0500
Received: from m1000.netcologne.de ([194.8.194.104]:14633 "EHLO
	m1000.netcologne.de") by vger.kernel.org with ESMTP
	id <S288921AbSCQK3t>; Sun, 17 Mar 2002 05:29:49 -0500
Message-Id: <200203171028.ALV49936@m1000.netcologne.de>
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre2-jp7 #1 Fre =?iso8859-15?q?M=E4r=208=2021=3A37=3A18=20CET=202002=20i686?= unknown
To: mdharm-usb@one-eyed-alien.net
Subject: [PATCH] LaCie USB CDRW
Date: Sun, 17 Mar 2002 11:28:14 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linuxppc-user@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_23546F8VOSQCVWI4XAB1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_23546F8VOSQCVWI4XAB1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi,

here is a Linux Kernel USB definition of the LaCie USB CDRW burner. This 
was missing from linux/drivers/usb/storage/unusual_devs.h, so the drive was 
recognized by USB, but not properly installed by the USB SCSI emulation.

I tested only reading yet, but I think writing works, too. Will be tested 
soon. I have an old model of 1999 with USB 1, 2x/2x/4x, and no FireWire 
Combo. The USB one is mainly used by Apple folks for CD burning, and will 
make those people happy. Current model can be found at

http://www.lacie.com/products/product.cfm?id=4A866A34-54C8-11D5-97C60090278D3ED0

This should be a fix to the LaCie USB burner trouble that has been reported 
in September 2002 to linuxppc-user.

http://www.geocrawler.com/mail/thread.php3?subject=Lacie+USB+Burner&list=2

Cheers,

Jörg
 
--------------Boundary-00=_23546F8VOSQCVWI4XAB1
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="usb-lacie-usb-cdrw.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="usb-lacie-usb-cdrw.diff"

LS0tIGxpbnV4L2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF9kZXZzLmgJTW9uIE1hciAxMSAx
NToxNzozOCAyMDAyCisrKyBsaW51eC1sYWNpZS9kcml2ZXJzL3VzYi9zdG9yYWdlL3VudXN1YWxf
ZGV2cy5oCVN1biBNYXIgMTcgMTA6NTY6MzcgMjAwMgpAQCAtMjUyLDYgKzI1MiwxMiBAQAogCQki
VVNCIEhhcmQgRGlzayIsCiAJCVVTX1NDX1JCQywgVVNfUFJfQ0IsIE5VTEwsIDAgKSwgCiAKKy8q
IFN1Ym1pdHRlZCBieSBK9nJnIFByYW50ZSA8am9lcmdAaW5mb2xpbnV4LmRlPiAqLworVU5VU1VB
TF9ERVYoICAweDA1OWYsIDB4YTYwMiwgMHgwMjAwLCAweDAyMDAsIAorCQkiTGFDaWUiLAorCQki
VVNCIE1hc3MgU1RPUkFHRSIsCisJCVVTX1NDX1NDU0ksIFVTX1BSX0NCLCBOVUxMLCAwICksIAor
CiAjaWZkZWYgQ09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMAogVU5VU1VBTF9ERVYoICAweDA1YWIs
IDB4MDAzMSwgMHgwMTAwLCAweDAxMTAsCiAgICAgICAgICAgICAgICAgIkluLVN5c3RlbSIsCg==

--------------Boundary-00=_23546F8VOSQCVWI4XAB1--
