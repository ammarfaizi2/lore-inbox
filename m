Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132461AbRALU6r>; Fri, 12 Jan 2001 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRALU6h>; Fri, 12 Jan 2001 15:58:37 -0500
Received: from piff.student.his.se ([193.10.177.40]:60356 "EHLO
	piff.student.his.se") by vger.kernel.org with ESMTP
	id <S132461AbRALU6X>; Fri, 12 Jan 2001 15:58:23 -0500
Date: Fri, 12 Jan 2001 21:58:12 +0100
From: Andreas Henriksson <andreas.henriksson@linux.se>
Subject: Adaptec 29160N + Quantum Atlas 10K = Kernel 2.4 will _NOT_ boot.
To: linux-kernel@vger.kernel.org
Message-id: <5.0.2.1.2.20010112211458.00b39c58@mail5.mail.home.se>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_oqslrptaGQkcL9Iy/5ipTQ)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_oqslrptaGQkcL9Iy/5ipTQ)
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT

from "Linux-2.4.x patch submission policy":

 > Another way of putting it: if you have a patch, ask yourself what
 > would happen if it got left off the next
 > RedHat/SuSE/Debian/Turbo/whatever distribution CD.  Would it really
 > be a big problem? If not, then I'd rather spend the time _really_
 > beating on the patches that _would_ be a big issue.  Things like 
security (_especially_
 > remote attacks), outright crashes, or just
 > totally unusable systems because it can't see the harddisk.

I get "Unknown device 24" when I try booting Kernel 2.4.0 (and it has been 
like this on all 2.4-test kernels too).

When I had my Plextor Plexwriter 8/2/20 CD-ROM attached it didn't even find 
my hard drive (Quantum Atlas 10K).

I have a Adaptec 29160N scsi card.

I've had some problems with 2.2.x too, sometimes it doesn't boot (time out 
and stuff like that on the scsi probing).

I have previously posted about this and none obviously cared, hope 
something will happen this time since I guess Adaptec 29160N + Quantum 
Atlas 10K would be a quite common combination. Anyone with the same 
hardware setup that would like to comment please mail me at 
andreas.henriksson@linux.se since I'm not on the linux-kernel mailing list. 
Comments would be appreciated.

Oh, by the way. Someone posted a patch for this that wasn't accepted. 
Reason: "It wasn't needed". (Although the patch didn't solve my second 
problem, the one with the cd-rom attached... still didn't find my hard 
drive). He/she had a Compaq something that also had problem booting. The 
patch was really just a 2.2.x rip off that added a few lines.

Ahh... still have it .. it's attached.
It probably won't apply cleanly but it's not that hard to do it manually. 
Better someone else fix it and resubmit it I'll probably just screw it up 
anyway. ;)

This patch was _not_ written by me, I don't really know what it does, and 
it doesn't solve the problem completely. (Booting 2.2.x isn't 100% reliable 
for me either, works most of the time though.)

I hope my english is understandable.

Best regards, Andreas Henriksson // andreas.henriksson@linux.se

--Boundary_(ID_oqslrptaGQkcL9Iy/5ipTQ)
Content-type: application/octet-stream; name=lin24scsi.patch
Content-disposition: attachment; filename=lin24scsi.patch
Content-transfer-encoding: base64

KioqIHNjc2lfc2Nhbi5jLm9yaWcgICAgVHVlIE9jdCAyNCAxNDowMTo1NCAyMDAwCi0tLSBzY3Np
X3NjYW4uYyBUaHUgTm92ICAyIDE4OjU5OjMwIDIwMDAKKioqKioqKioqKioqKioqCioqKiA0NzEs
NDc2ICoqKioKLS0tIDQ3MSw0NzkgLS0tLQogICAgICAgIFNjc2lfUmVxdWVzdCAqIFNScG50Owog
ICAgICAgIGludCBiZmxhZ3MsIHR5cGUgPSAtMTsKICAgICAgICBleHRlcm4gZGV2ZnNfaGFuZGxl
X3Qgc2NzaV9kZXZmc19oYW5kbGU7CisgICAgICAgaW50IHNwaW50aW1lID0gMDsKKyAgICAgICBp
bnQgcmV0cmllcyA9IDA7CisgICAgICAgdW5zaWduZWQgbG9uZyBzcGludGltZV92YWx1ZSA9IDA7
CiAgCiAgICAgICAgU0RwbnQtPmhvc3QgPSBzaHBudDsKICAgICAgICBTRHBudC0+aWQgPSBkZXY7
CioqKioqKioqKioqKioqKgoqKiogNDk5LDUwNCAqKioqCi0tLSA1MDIsNTc0IC0tLS0KICAgICAg
ICAgKiBub3QgcmVhbGx5IG5lY2Vzc2FyeS4gIFNwZWMgcmVjb21tZW5kcyB1c2luZyBJTlFVSVJZ
IHRvIHNjYW4gZm9yCiAgICAgICAgICogZGV2aWNlcyAoYW5kIFRFU1RfVU5JVF9SRUFEWSB0byBw
b2xsIGZvciBtZWRpYSBjaGFuZ2UpLiAtIFBhdWwgRy4KICAgICAgICAgKi8KKyAvKiBBZGQgVFVS
IGJhY2sgaW4gdG8gc3luYyB1cCB0aGUgZGlzayAtLSAKKyAgICBtb3N0bHkgYm9ycm93ZWQgZnJv
bSAyLjIga2VybmVsICAtLSBlYW1iICovCisgCisgICAgICAgZG8gICAgICAKKyAgICAgICB7Cisg
ICAgICAgICAgICAgICAgIHJldHJpZXMgPSAwOworIAorICAgICAgICAgICAgICAgICB3aGlsZSAo
cmV0cmllcyA8IDMpIAorICAgICAgICAgICAgICAgeworICAgICAgICAgICAgICAgICAgICAgICAg
IHNjc2lfY21kWzBdID0gVEVTVF9VTklUX1JFQURZOworICAgICAgICAgICAgICAgICAgICAgICAg
IHNjc2lfY21kWzFdID0gKGx1biA8PCA1KSAmIDB4ZTA7CisgICAgICAgICAgICAgICAgICAgICAg
ICAgbWVtc2V0KCh2b2lkICopICZzY3NpX2NtZFsyXSwgMCwgOCk7CisgICAgICAgICAgICAgICAg
ICAgICAgICAgU1JwbnQtPnNyX2NtZF9sZW4gPSAwOworICAgICAgICAgICAgICAgICAgICAgICAg
IFNScG50LT5zcl9zZW5zZV9idWZmZXJbMF0gPSAwOworICAgICAgICAgICAgICAgICAgICAgICAg
IFNScG50LT5zcl9zZW5zZV9idWZmZXJbMl0gPSAwOworICAgICAgICAgICAgICAgICAgICAgICAg
IFNScG50LT5zcl9kYXRhX2RpcmVjdGlvbiA9IFNDU0lfREFUQV9SRUFEOworIAorICAgICAgICAg
ICAgICAgICAgICAgICBzY3NpX3dhaXRfcmVxIChTUnBudCwgKHZvaWQgKikgc2NzaV9jbWQsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKikgc2NzaV9yZXN1bHQsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMjU2LCBTQ1NJX1RJTUVPVVQrNCpIWiwgMyk7Cisg
CisgICAgICAgICAgICAgICAgICAgICAgICAgcmV0cmllcysrOworICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChTUnBudC0+c3JfcmVzdWx0ID09IDAKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfHwgU1JwbnQtPnNyX3NlbnNlX2J1ZmZlclsyXSAhPSBVTklUX0FUVEVOVElPTikKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgICAgICB9
CisgCisgICAgICAgICAgICAgICAgIGlmKCBTUnBudC0+c3JfcmVzdWx0ICE9IDAKKyAgICAgICAg
ICAgICAgICAgICAgICYmICgoZHJpdmVyX2J5dGUoU1JwbnQtPnNyX3Jlc3VsdCkgJiBEUklWRVJf
U0VOU0UpICE9IDApCisgICAgICAgICAgICAgICAgICAgICAmJiBTUnBudC0+c3Jfc2Vuc2VfYnVm
ZmVyWzJdID09IFVOSVRfQVRURU5USU9OKQorICAgICAgICAgICAgICAgeworICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgICAgICB9CisgCisgICAgICAgICAgICAg
ICAgIC8qIExvb2sgZm9yIGRldmljZXMgdGhhdCBhcmUgTk9UX1JFQURZLgorICAgICAgICAgICAg
ICAgICAgKiBJc3N1ZSBjb21tYW5kIHRvIHNwaW4gdXAgZHJpdmUgZm9yIHRoZXNlIGNhc2VzLiAq
LworICAgICAgICAgICAgICAgICBpZihTUnBudC0+c3Jfc2Vuc2VfYnVmZmVyWzJdID09IE5PVF9S
RUFEWSkgCisgICAgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyB0aW1lMTsKKyAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXNwaW50aW1lKSAK
KyAgICAgICAgICAgICAgICAgICAgICAgeworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2NzaV9jbWRbMF0gPSBTVEFSVF9TVE9QOworICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2NzaV9jbWRbMV0gPSAobHVuIDw8IDUpICYgMHhlMDsKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNjc2lfY21kWzFdIHw9IDE7ICAgIC8qIFJldHVybiBpbW1lZGlhdGVs
eSAqLworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KCh2b2lkICopICZz
Y3NpX2NtZFsyXSwgMCwgOCk7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY3Np
X2NtZFs0XSA9IDE7ICAgICAvKiBTdGFydCBzcGluIGN5Y2xlICovCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTUnBudC0+c3JfY21kX2xlbiA9IDA7CisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTUnBudC0+c3Jfc2Vuc2VfYnVmZmVyWzBdID0gMDsKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFNScG50LT5zcl9zZW5zZV9idWZmZXJbMl0gPSAwOwor
IAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1JwbnQtPnNyX2RhdGFfZGlyZWN0
aW9uID0gU0NTSV9EQVRBX1JFQUQ7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Nz
aV93YWl0X3JlcSAoU1JwbnQsICh2b2lkICopIHNjc2lfY21kLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKikgc2NzaV9yZXN1bHQsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAyNTYsIFNDU0lfVElNRU9VVCs0KkhaLCAzKTsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICB9CisgICAgICAgICAgICAgICAgICAgICAgICAgc3BpbnRp
bWUgPSAxOworICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW50aW1lX3ZhbHVlID0gamlmZmll
czsKKyAgICAgICAgICAgICAgICAgICAgICAgICB0aW1lMSA9IEhaOworICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIFdhaXQgMSBzZWNvbmQgZm9yIG5leHQgdHJ5ICovCisgICAgICAgICAgICAg
ICAgICAgICAgICAgZG8gCisgICAgICAgICAgICAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGN1cnJlbnQtPnN0YXRlID0gVEFTS19VTklOVEVSUlVQVElCTEU7
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aW1lMSA9IHNjaGVkdWxlX3RpbWVv
dXQodGltZTEpOworICAgICAgICAgICAgICAgICAgICAgICAgIH0gd2hpbGUodGltZTEpOworICAg
ICAgICAgICAgICAgICB9CisgICAgICAgICB9IHdoaWxlIChTUnBudC0+c3JfcmVzdWx0ICYmIHNw
aW50aW1lICYmIChyZXRyaWVzIDwgMykgJiYKKyAgICAgICAgICAgICAgICAgIHRpbWVfYWZ0ZXIo
c3BpbnRpbWVfdmFsdWUgKyAxMDAgKiBIWiwgamlmZmllcykpOwogIAogICAgICAgIFNDU0lfTE9H
X1NDQU5fQlVTKDMsIHByaW50aygic2NzaTogcGVyZm9ybWluZyBJTlFVSVJZXG4iKSk7CiAgICAg
ICAgLyoKCg==

--Boundary_(ID_oqslrptaGQkcL9Iy/5ipTQ)--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
