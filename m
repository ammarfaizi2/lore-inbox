Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbRG3UiH>; Mon, 30 Jul 2001 16:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267825AbRG3UiA>; Mon, 30 Jul 2001 16:38:00 -0400
Received: from riker.skynet.be ([195.238.3.132]:5967 "EHLO riker.skynet.be")
	by vger.kernel.org with ESMTP id <S267850AbRG3Uhr>;
	Mon, 30 Jul 2001 16:37:47 -0400
From: Laurent Pinchart <laurent.pinchart@skynet.be>
Date: Mon, 30 Jul 2001 22:35:44 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="us-ascii";
  boundary="------------Boundary-00=_KVZAMRP3EGUSRYELJXLF"
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
To: acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <Pine.LNX.4.31.0107271525220.3001-100000@phobos.fachschaften.tu-muenchen.de> <3B659E2D.E6FB92EA@fc.hp.com>
In-Reply-To: <3B659E2D.E6FB92EA@fc.hp.com>
Subject: acpitbl bug
MIME-Version: 1.0
Message-Id: <01073022354400.00269@peter_pan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_KVZAMRP3EGUSRYELJXLF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The acpitbl perl script doesn't display correctly the contents of the FADT 
table flags, due to a 3-byte reserved field which is not handled correctly in 
the show_table function.

I attached a patch to this e-mail.

Best regards,

Laurent Pinchart

--------------Boundary-00=_KVZAMRP3EGUSRYELJXLF
Content-Type: text/plain;
  name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

ZGlmZiAtTmF1ciBvbGQvYWNwaXRibCBuZXcvYWNwaXRibAotLS0gb2xkL2FjcGl0YmwJVHVlIEFw
ciAyNSAxNjozNzoxMSAyMDAwCisrKyBuZXcvYWNwaXRibAlNb24gSnVsIDMwIDIyOjMxOjQ4IDIw
MDEKQEAgLTY0LDEzICs2NCwxNSBAQAogewogICAgIGxvY2FsKCpPVVQsICpkZXNjLCAqZGF0YSkg
PSBAXzsKICAgICBteSglc2l6ZV90b190bXBsKSA9Ci0JKCJEMSI9PiJDIiwgIkQyIj0+IlMiLCAi
RDQiPT4iSSIsCi0JICJYMSI9PiJDIiwgIlgyIj0+IlMiLCAiWDQiPT4iSSIsCi0JICJBNCI9PiJB
NCIsICJBNiI9PiJBNiIsICJBOCI9PiJBOCIpOworCSgiRDEiPT4iQyIsICJEMiI9PiJTIiwgICJE
NCI9PiJJIiwKKwkgIlgxIj0+IkMiLCAiWDIiPT4iUyIsICAiWDMiPT4iYTMiLAorCSAiWDQiPT4i
SSIsICJBNCI9PiJBNCIsICJBNiI9PiJBNiIsCisJICJBOCI9PiJBOCIpOwogICAgIG15KCVzaXpl
X3RvX2ZtdCkgPQogCSgiRDEiPT4iJWQiLCAiRDIiPT4iJWQiLCAiRDQiPT4iJWQiLAotCSAiWDEi
PT4iMHglMDJ4IiwgIlgyIj0+IjB4JTA0eCIsICJYNCI9PiIweCUwOHgiLAotCSAiQTQiPT4iJXMi
LCAiQTYiPT4iJXMiLCAiQTgiPT4iJXMiKTsKKwkgIlgxIj0+IjB4JTAyeCIsICJYMiI9PiIweCUw
NHgiLCAiWDMiPT4iMHglMDZ4IiwKKwkgIlg0Ij0+IjB4JTA4eCIsICJBNCI9PiIlcyIsICJBNiI9
PiIlcyIsCisJICJBOCI9PiIlcyIpOwogCiAgICAgbXkoJHRtcGwpID0gIiI7CiAgICAgbXkoJG1h
eF9zaXplKSA9IDA7Cg==

--------------Boundary-00=_KVZAMRP3EGUSRYELJXLF--
