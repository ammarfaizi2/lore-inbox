Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTIDHmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTIDHmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:42:31 -0400
Received: from smtp.wp.pl ([212.77.101.161]:4904 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264832AbTIDHky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:40:54 -0400
Date: Thu, 4 Sep 2003 09:40:50 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Fw: Re: Linux 2.4.23-pre3
Message-Id: <20030904094050.67f872d9.rmrmg@wp.pl>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__4_Sep_2003_09_40_50_+0200_08245770"
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__4_Sep_2003_09_40_50_+0200_08245770
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

make dep:
[...]
make -C eicon fastdep
make[6]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/eicon'/usr/src/linux-2.4.23-pr
e3/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.23-pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix
include -- Divas_mod.c adapter.h bri.c common.c constant.h divalog.h
divas.h dsp_defs.h dspdids.h eicon.h eicon_dsp.h eicon_idi.c eicon_idi.h
eicon_io.c eicon_isa.c eicon_isa.h eicon_mod.c eicon_pci.c eicon_pci.h
fourbri.c fpga.c idi.c idi.h kprintf.c lincfg.c linchr.c linio.c
linsys.c log.c pc.h pc_maint.h pr_pc.h pri.c sys.h uxio.h xlog.c >
.depend make[6]: Leaving directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/eicon' make -C hisax fastdep

md5sum: WARNING: 1 of 13 computed checksums did NOT match

make[6]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax'
[...]

make bzImage:
[...]
make -C isdn
make[2]: Entering directory `/usr/src/linux-2.4.23-pre3/drivers/isdn'
make -C hisax

md5sum: WARNING: 1 of 13 computed checksums did NOT match

make[3]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax' make all_targets

md5sum: WARNING: 1 of 13 computed checksums did NOT match

make[4]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax' rm -f vmlinux-obj.o
ar rcs vmlinux-obj.o
make[4]: Leaving directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax' make[3]: Leaving
directory `/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax' make
all_targets make[3]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn' rm -f vmlinux-obj.o
ld -m elf_i386  -r -o vmlinux-obj.o hisax/vmlinux-obj.o
make[3]: Leaving directory `/usr/src/linux-2.4.23-pre3/drivers/isdn'
make[2]: Leaving directory `/usr/src/linux-2.4.23-pre3/drivers/isdn'
[...]

make modules:
[...]
make[2]: Entering directory `/usr/src/linux-2.4.23-pre3/drivers/isdn'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_net  -c -o
isdn_net.o isdn_net.c gcc -D__KERNEL__
-I/usr/src/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_tty  -c -o
isdn_tty.o isdn_tty.c gcc -D__KERNEL__
-I/usr/src/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_v110  -c -o
isdn_v110.o isdn_v110.cgcc -D__KERNEL__
-I/usr/src/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_common 
-DEXPORT_SYMTAB -c isdn_common.c gcc -D__KERNEL__
-I/usr/src/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_ppp  -c -o
isdn_ppp.o isdn_ppp.c ld -m elf_i386 -r -o isdn.o isdn_net.o isdn_tty.o
isdn_v110.o isdn_common.o isdn_ppp.o gcc -D__KERNEL__
-I/usr/src/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS
-include /usr/src/linux-2.4.23-pre3/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=isdn_bsdcomp  -c -o
isdn_bsdcomp.o isdn_bsdcomp.c make -C hisax modules

md5sum: WARNING: 1 of 13 computed checksums did NOT match

make[3]: Entering directory
`/usr/src/linux-2.4.23-pre3/drivers/isdn/hisax'
[...]

Config in attachment.


-- 
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji

--Multipart_Thu__4_Sep_2003_09_40_50_+0200_08245770
Content-Type: application/octet-stream;
 name="config"
Content-Disposition: attachment;
 filename="config"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGJ5IG1ha2UgbWVudWNvbmZpZzogZG9uJ3QgZWRp
dAojCkNPTkZJR19YODY9eQpDT05GSUdfVUlEMTY9eQoKIwojIENvZGUgbWF0dXJpdHkgbGV2ZWwg
b3B0aW9ucwojCkNPTkZJR19FWFBFUklNRU5UQUw9eQoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBw
b3J0CiMKQ09ORklHX01PRFVMRVM9eQpDT05GSUdfTU9EVkVSU0lPTlM9eQpDT05GSUdfS01PRD15
CgojCiMgUHJvY2Vzc29yIHR5cGUgYW5kIGZlYXR1cmVzCiMKQ09ORklHX01LNz15CkNPTkZJR19Y
ODZfV1BfV09SS1NfT0s9eQpDT05GSUdfWDg2X0lOVkxQRz15CkNPTkZJR19YODZfQ01QWENIRz15
CkNPTkZJR19YODZfWEFERD15CkNPTkZJR19YODZfQlNXQVA9eQpDT05GSUdfWDg2X1BPUEFEX09L
PXkKQ09ORklHX1JXU0VNX1hDSEdBRERfQUxHT1JJVEhNPXkKQ09ORklHX1g4Nl9MMV9DQUNIRV9T
SElGVD02CkNPTkZJR19YODZfSEFTX1RTQz15CkNPTkZJR19YODZfR09PRF9BUElDPXkKQ09ORklH
X1g4Nl9VU0VfM0ROT1c9eQpDT05GSUdfWDg2X1BHRT15CkNPTkZJR19YODZfVVNFX1BQUk9fQ0hF
Q0tTVU09eQpDT05GSUdfWDg2X0YwMEZfV09SS1NfT0s9eQpDT05GSUdfWDg2X01DRT15CkNPTkZJ
R19OT0hJR0hNRU09eQpDT05GSUdfTVRSUj15CkNPTkZJR19YODZfVVBfQVBJQz15CkNPTkZJR19Y
ODZfTE9DQUxfQVBJQz15CkNPTkZJR19YODZfVFNDPXkKCiMKIyBHZW5lcmFsIHNldHVwCiMKQ09O
RklHX05FVD15CkNPTkZJR19QQ0k9eQpDT05GSUdfUENJX0dPQU5ZPXkKQ09ORklHX1BDSV9CSU9T
PXkKQ09ORklHX1BDSV9ESVJFQ1Q9eQpDT05GSUdfUENJX05BTUVTPXkKQ09ORklHX1NZU1ZJUEM9
eQpDT05GSUdfU1lTQ1RMPXkKQ09ORklHX0tDT1JFX0VMRj15CkNPTkZJR19CSU5GTVRfQU9VVD15
CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkKQ09ORklHX1BNPXkKQ09O
RklHX0FQTT1tCkNPTkZJR19BUE1fUkVBTF9NT0RFX1BPV0VSX09GRj15CgojCiMgQUNQSSBTdXBw
b3J0CiMKCiMKIyBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIChNVEQpCiMKCiMKIyBQYXJhbGxl
bCBwb3J0IHN1cHBvcnQKIwoKIwojIFBsdWcgYW5kIFBsYXkgY29uZmlndXJhdGlvbgojCkNPTkZJ
R19QTlA9eQoKIwojIEJsb2NrIGRldmljZXMKIwpDT05GSUdfQkxLX0RFVl9GRD1tCkNPTkZJR19C
TEtfREVWX0xPT1A9bQpDT05GSUdfQkxLX0RFVl9OQkQ9bQpDT05GSUdfQkxLX0RFVl9SQU09bQpD
T05GSUdfQkxLX0RFVl9SQU1fU0laRT00MDk2CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQgKFJB
SUQgYW5kIExWTSkKIwoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCkNPTkZJR19QQUNLRVQ9eQpD
T05GSUdfTkVURklMVEVSPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNPTkZJR19JUF9N
VUxUSUNBU1Q9eQoKIwojICAgSVA6IE5ldGZpbHRlciBDb25maWd1cmF0aW9uCiMKQ09ORklHX0lQ
X05GX0lQVEFCTEVTPW0KQ09ORklHX0lQX05GX0ZJTFRFUj1tCkNPTkZJR19JUF9ORl9UQVJHRVRf
UkVKRUNUPW0KCiMKIyAgIElQOiBWaXJ0dWFsIFNlcnZlciBDb25maWd1cmF0aW9uCiMKCiMKIyBB
cHBsZXRhbGsgZGV2aWNlcwojCgojCiMgUW9TIGFuZC9vciBmYWlyIHF1ZXVlaW5nCiMKCiMKIyBO
ZXR3b3JrIHRlc3RpbmcKIwoKIwojIFRlbGVwaG9ueSBTdXBwb3J0CiMKCiMKIyBBVEEvSURFL01G
TS9STEwgc3VwcG9ydAojCkNPTkZJR19JREU9eQoKIwojIElERSwgQVRBIGFuZCBBVEFQSSBCbG9j
ayBkZXZpY2VzCiMKQ09ORklHX0JMS19ERVZfSURFPXkKQ09ORklHX0JMS19ERVZfSURFRElTSz15
CkNPTkZJR19JREVESVNLX01VTFRJX01PREU9eQpDT05GSUdfQkxLX0RFVl9JREVDRD15CkNPTkZJ
R19CTEtfREVWX0lERVNDU0k9bQpDT05GSUdfQkxLX0RFVl9JREVQQ0k9eQpDT05GSUdfSURFUENJ
X1NIQVJFX0lSUT15CkNPTkZJR19CTEtfREVWX0lERURNQV9QQ0k9eQpDT05GSUdfSURFRE1BX1BD
SV9BVVRPPXkKQ09ORklHX0JMS19ERVZfSURFRE1BPXkKQ09ORklHX0JMS19ERVZfQU1ENzRYWD15
CkNPTkZJR19CTEtfREVWX1NJSU1BR0U9eQpDT05GSUdfSURFRE1BX0FVVE89eQpDT05GSUdfQkxL
X0RFVl9JREVfTU9ERVM9eQoKIwojIFNDU0kgc3VwcG9ydAojCkNPTkZJR19TQ1NJPW0KQ09ORklH
X0JMS19ERVZfU1I9bQpDT05GSUdfU1JfRVhUUkFfREVWUz0yCkNPTkZJR19DSFJfREVWX1NHPW0K
CiMKIyBTQ1NJIGxvdy1sZXZlbCBkcml2ZXJzCiMKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBw
b3J0CiMKCiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0IChFWFBFUklNRU5UQUwpCiMK
CiMKIyBJMk8gZGV2aWNlIHN1cHBvcnQKIwoKIwojIE5ldHdvcmsgZGV2aWNlIHN1cHBvcnQKIwpD
T05GSUdfTkVUREVWSUNFUz15CgojCiMgQVJDbmV0IGRldmljZXMKIwpDT05GSUdfRFVNTVk9bQoK
IwojIEV0aGVybmV0ICgxMCBvciAxMDBNYml0KQojCgojCiMgRXRoZXJuZXQgKDEwMDAgTWJpdCkK
IwoKIwojIFdpcmVsZXNzIExBTiAobm9uLWhhbXJhZGlvKQojCgojCiMgVG9rZW4gUmluZyBkZXZp
Y2VzCiMKCiMKIyBXYW4gaW50ZXJmYWNlcwojCgojCiMgQW1hdGV1ciBSYWRpbyBzdXBwb3J0CiMK
CiMKIyBJckRBIChpbmZyYXJlZCkgc3VwcG9ydAojCgojCiMgSVNETiBzdWJzeXN0ZW0KIwpDT05G
SUdfSVNETj1tCkNPTkZJR19JU0ROX0JPT0w9eQpDT05GSUdfSVNETl9QUFA9eQpDT05GSUdfSVNE
Tl9NUFA9eQpDT05GSUdfSVNETl9QUFBfQlNEQ09NUD1tCgojCiMgSVNETiBmZWF0dXJlIHN1Ym1v
ZHVsZXMKIwoKIwojIFBhc3NpdmUgSVNETiBjYXJkcwojCkNPTkZJR19JU0ROX0RSVl9ISVNBWD1t
CkNPTkZJR19JU0ROX0hJU0FYPXkKQ09ORklHX0hJU0FYX0VVUk89eQpDT05GSUdfSElTQVhfTUFY
X0NBUkRTPTgKQ09ORklHX0hJU0FYX0ZSSVRaUENJPXkKQ09ORklHX0hJU0FYX0RFQlVHPXkKCiMK
IyBBY3RpdmUgSVNETiBjYXJkcwojCgojCiMgSW5wdXQgY29yZSBzdXBwb3J0CiMKCiMKIyBDaGFy
YWN0ZXIgZGV2aWNlcwojCkNPTkZJR19WVD15CkNPTkZJR19WVF9DT05TT0xFPXkKQ09ORklHX1NF
UklBTD15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19VTklYOThfUFRZX0NPVU5UPTI1NgoK
IwojIEkyQyBzdXBwb3J0CiMKQ09ORklHX0kyQz1tCkNPTkZJR19JMkNfQUxHT0JJVD1tCgojCiMg
TWljZQojCkNPTkZJR19NT1VTRT15CkNPTkZJR19QU01PVVNFPXkKCiMKIyBKb3lzdGlja3MKIwoK
IwojIFdhdGNoZG9nIENhcmRzCiMKQ09ORklHX05WUkFNPW0KQ09ORklHX1JUQz1tCgojCiMgRnRh
cGUsIHRoZSBmbG9wcHkgdGFwZSBkZXZpY2UgZHJpdmVyCiMKQ09ORklHX0FHUD1tCkNPTkZJR19B
R1BfTlZJRElBPXkKCiMKIyBEaXJlY3QgUmVuZGVyaW5nIE1hbmFnZXIgKFhGcmVlODYgRFJJIHN1
cHBvcnQpCiMKQ09ORklHX0RSTT15CkNPTkZJR19EUk1fTkVXPXkKQ09ORklHX0RSTV9SQURFT049
bQoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCkNPTkZJR19WSURFT19ERVY9bQoKIwojIFZpZGVv
IEZvciBMaW51eAojCkNPTkZJR19WSURFT19CVDg0OD1tCgojCiMgUmFkaW8gQWRhcHRlcnMKIwoK
IwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19BVVRPRlM0X0ZTPXkKQ09ORklHX1JFSVNFUkZTX0ZT
PXkKQ09ORklHX0VYVDNfRlM9eQpDT05GSUdfSkJEPXkKQ09ORklHX0ZBVF9GUz1tCkNPTkZJR19N
U0RPU19GUz1tCkNPTkZJR19WRkFUX0ZTPW0KQ09ORklHX1RNUEZTPXkKQ09ORklHX1JBTUZTPXkK
Q09ORklHX0lTTzk2NjBfRlM9bQpDT05GSUdfSk9MSUVUPXkKQ09ORklHX1pJU09GUz15CkNPTkZJ
R19QUk9DX0ZTPXkKQ09ORklHX0RFVlBUU19GUz15CkNPTkZJR19FWFQyX0ZTPXkKCiMKIyBOZXR3
b3JrIEZpbGUgU3lzdGVtcwojCkNPTkZJR19aSVNPRlNfRlM9bQoKIwojIFBhcnRpdGlvbiBUeXBl
cwojCkNPTkZJR19NU0RPU19QQVJUSVRJT049eQpDT05GSUdfTkxTPXkKCiMKIyBOYXRpdmUgTGFu
Z3VhZ2UgU3VwcG9ydAojCkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0yIgpDT05GSUdfTkxT
X0NPREVQQUdFXzg1Mj1tCkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MD1tCkNPTkZJR19OTFNfSVNP
ODg1OV8yPW0KQ09ORklHX05MU19VVEY4PW0KCiMKIyBDb25zb2xlIGRyaXZlcnMKIwpDT05GSUdf
VkdBX0NPTlNPTEU9eQpDT05GSUdfVklERU9fU0VMRUNUPXkKCiMKIyBGcmFtZS1idWZmZXIgc3Vw
cG9ydAojCkNPTkZJR19GQj15CkNPTkZJR19EVU1NWV9DT05TT0xFPXkKQ09ORklHX0ZCX1ZFU0E9
eQpDT05GSUdfVklERU9fU0VMRUNUPXkKQ09ORklHX0ZCQ09OX0NGQjg9eQpDT05GSUdfRkJDT05f
Q0ZCMTY9eQpDT05GSUdfRkJDT05fQ0ZCMjQ9eQpDT05GSUdfRkJDT05fQ0ZCMzI9eQpDT05GSUdf
Rk9OVF84eDg9eQpDT05GSUdfRk9OVF84eDE2PXkKCiMKIyBTb3VuZAojCkNPTkZJR19TT1VORD15
CkNPTkZJR19TT1VORF9FTVUxMEsxPXkKQ09ORklHX1NPVU5EX1RWTUlYRVI9bQoKIwojIFVTQiBz
dXBwb3J0CiMKCiMKIyBCbHVldG9vdGggc3VwcG9ydAojCgojCiMgS2VybmVsIGhhY2tpbmcKIwpD
T05GSUdfREVCVUdfS0VSTkVMPXkKQ09ORklHX01BR0lDX1NZU1JRPXkKQ09ORklHX0ZSQU1FX1BP
SU5URVI9eQpDT05GSUdfTE9HX0JVRl9TSElGVD0wCgojCiMgQ3J5cHRvZ3JhcGhpYyBvcHRpb25z
CiMKCiMKIyBMaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX1pMSUJfSU5GTEFURT1tCg==

--Multipart_Thu__4_Sep_2003_09_40_50_+0200_08245770--
