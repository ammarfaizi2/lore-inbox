Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbRGUN1n>; Sat, 21 Jul 2001 09:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbRGUN1d>; Sat, 21 Jul 2001 09:27:33 -0400
Received: from binky.de.uu.net ([192.76.144.28]:43720 "EHLO binky.de.uu.net")
	by vger.kernel.org with ESMTP id <S267632AbRGUN1Y>;
	Sat, 21 Jul 2001 09:27:24 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-15";
  boundary="------------Boundary-00=_Y0ST4DSIL7FVO4E9B5NP"
From: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
To: linux-kernel@vger.kernel.org
Subject: MO-Drive under 2.4.7 usinf vfat
Date: Sat, 21 Jul 2001 15:26:58 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072115265800.02284@majestix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_Y0ST4DSIL7FVO4E9B5NP
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Hi all,

I have just tested the new 2.4.7 kernel to see, whether it now works with a 
MO-Drive using the vfat filesystem. Unfortunately it still doesn't. Mounting 
a disk and writing to it is ok. However, when I try to read a file off the 
disk, the program crashes with a Segmentation fault and I get a oops in the 
messages file (see attachment). I tried ksymoops on this file, but either I 
did something wrong or it couldn't analyse it.

I hope, this issue will be fixed soon cause I would like to switch over to 
the 2.4 kernel series without scratching my set of MO-disks.

Regards
Detlev

Btw, please answer by email as well because I think I got removed from the 
mailing list somehow (or is it that quiet?).
-- 
Detlev Offenbach
detlev@offenbach.fs.uunet.de

--------------Boundary-00=_Y0ST4DSIL7FVO4E9B5NP
Content-Type: text/plain;
  charset="iso-8859-15";
  name="oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oops.txt"

SnVsIDIxIDE0OjM4OjIxIG1hamVzdGl4IGtlcm5lbDogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMApKdWwg
MjEgMTQ6Mzg6MjEgbWFqZXN0aXgga2VybmVsOiAgcHJpbnRpbmcgZWlwOgpKdWwgMjEgMTQ6Mzg6
MjEgbWFqZXN0aXgga2VybmVsOiAwMDAwMDAwMApKdWwgMjEgMTQ6Mzg6MjEgbWFqZXN0aXgga2Vy
bmVsOiAqcGRlID0gMDAwMDAwMDAKSnVsIDIxIDE0OjM4OjIxIG1hamVzdGl4IGtlcm5lbDogT29w
czogMDAwMApKdWwgMjEgMTQ6Mzg6MjEgbWFqZXN0aXgga2VybmVsOiBDUFU6ICAgIDAKSnVsIDIx
IDE0OjM4OjIxIG1hamVzdGl4IGtlcm5lbDogRUlQOiAgICAwMDEwOls8MDAwMDAwMDA+XQpKdWwg
MjEgMTQ6Mzg6MjEgbWFqZXN0aXgga2VybmVsOiBFRkxBR1M6IDAwMDEwMjgyCkp1bCAyMSAxNDoz
ODoyMSBtYWplc3RpeCBrZXJuZWw6IGVheDogMDAwMDAwMDAgICBlYng6IGQ3MjlkY2MwICAgZWN4
OiAwMDAwNDAwMCAgIGVkeDogZDcyOWRjZTAKSnVsIDIxIDE0OjM4OjIxIG1hamVzdGl4IGtlcm5l
bDogZXNpOiA0MDAxNzAwMCAgIGVkaTogMDAwMDAwMDAgICBlYnA6IDAwMDA0MDAwICAgZXNwOiBk
NzI3ZmY4MApKdWwgMjEgMTQ6Mzg6MjEgbWFqZXN0aXgga2VybmVsOiBkczogMDAxOCAgIGVzOiAw
MDE4ICAgc3M6IDAwMTgKSnVsIDIxIDE0OjM4OjIxIG1hamVzdGl4IGtlcm5lbDogUHJvY2VzcyBt
b3JlIChwaWQ6IDExOTEsIHN0YWNrcGFnZT1kNzI3ZjAwMCkKSnVsIDIxIDE0OjM4OjIxIG1hamVz
dGl4IGtlcm5lbDogU3RhY2s6IGUyYmFkOGZkIGQ3MjlkY2MwIDQwMDE3MDAwIDAwMDA0MDAwIGQ3
MjlkY2UwIGQ3MjlkY2MwIGZmZmZmZmVhIGMwMTJlMTU2IApKdWwgMjEgMTQ6Mzg6MjEgbWFqZXN0
aXgga2VybmVsOiAgICAgICAgZDcyOWRjYzAgNDAwMTcwMDAgMDAwMDQwMDAgZDcyOWRjZTAgZDcy
N2UwMDAgMDgwNTBiNjggMDgwNTBiNjggYmZmZmY0OWMgCkp1bCAyMSAxNDozODoyMSBtYWplc3Rp
eCBrZXJuZWw6ICAgICAgICBjMDEwNmMyYiAwMDAwMDAwMyA0MDAxNzAwMCAwMDAwNDAwMCAwODA1
MGI2OCAwODA1MGI2OCBiZmZmZjQ5YyAwMDAwMDAwMyAKSnVsIDIxIDE0OjM4OjIxIG1hamVzdGl4
IGtlcm5lbDogQ2FsbCBUcmFjZTogW3N5c19yZWFkKzE1MC8yMDhdIFtzeXN0ZW1fY2FsbCs1MS81
Nl0gCkp1bCAyMSAxNDozODoyMSBtYWplc3RpeCBrZXJuZWw6IApKdWwgMjEgMTQ6Mzg6MjEgbWFq
ZXN0aXgga2VybmVsOiBDb2RlOiAgQmFkIEVJUCB2YWx1ZS4K

--------------Boundary-00=_Y0ST4DSIL7FVO4E9B5NP--
