Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293024AbSCJMsQ>; Sun, 10 Mar 2002 07:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSCJMsG>; Sun, 10 Mar 2002 07:48:06 -0500
Received: from [194.228.240.11] ([194.228.240.11]:63916 "EHLO sakal.vgd.cz")
	by vger.kernel.org with ESMTP id <S293024AbSCJMr7>;
	Sun, 10 Mar 2002 07:47:59 -0500
Subject: [PATCH] Build problems with kernel 2.5.6
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF9FF3C291.B3900C38-ONC1256B78.0037B49E@vgd.cz>
From: Petr.Titera@whitesoft.cz
Date: Sun, 10 Mar 2002 12:15:56 +0100
X-MIMETrack: Serialize by Router on Sakal/SRV/SOCO/CZ(Release 5.0.8 |June 18, 2001) at
 03/10/2002 01:47:58 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=C1256B780037B49E8f9e8a93df938690918cC1256B780037B49E"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=C1256B780037B49E8f9e8a93df938690918cC1256B780037B49E
Content-type: text/plain; charset=us-ascii

(See attached file: 08-ide-scsi.patch)Hello,

I have two problems with building kernel version 2.5.6.

 - kernel cannot be build with ide-scsi support. Attached patch solves my
problems.
 - ALSA cannod be sucessfully build for AWE 64 without CSP support. depmod
for snd-opl3-lib.o fails and driver does not initialize itself

Petr Titera

--0__=C1256B780037B49E8f9e8a93df938690918cC1256B780037B49E
Content-type: application/octet-stream; 
	name="08-ide-scsi.patch"
Content-Disposition: attachment; filename="08-ide-scsi.patch"
Content-transfer-encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS5jLm9yaWcJU2F0IE1hciAgOSAxODoyNToxMyAyMDAy
CisrKyBsaW51eC9kcml2ZXJzL2lkZS9pZGUuYwlTYXQgTWFyICA5IDE4OjI1OjMwIDIwMDIKQEAg
LTM3MDQsMTQgKzM3MDQsNiBAQAogI2lmZGVmIENPTkZJR19CTEtfREVWX0lERUZMT1BQWQogCWlk
ZWZsb3BweV9pbml0KCk7CiAjZW5kaWYKLSNpZmRlZiBDT05GSUdfQkxLX0RFVl9JREVTQ1NJCi0j
IGlmZGVmIENPTkZJR19TQ1NJCi0JaWRlc2NzaV9pbml0KCk7Ci0jIGVsc2UKLSAgICN3YXJuaW5n
IEFUQSBTQ1NJIGVtdWxhdGlvbiBzZWxlY3RlZCBidXQgbm8gU0NTSS1zdWJzeXN0ZW0gaW4ga2Vy
bmVsCi0jIGVuZGlmCi0jZW5kaWYKLQogCWluaXRpYWxpemluZyA9IDA7CiAKIAlmb3IgKGkgPSAw
OyBpIDwgTUFYX0hXSUZTOyArK2kpIHsK

--0__=C1256B780037B49E8f9e8a93df938690918cC1256B780037B49E--

