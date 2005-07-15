Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbVGOFME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbVGOFME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbVGOFMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:12:03 -0400
Received: from web32013.mail.mud.yahoo.com ([68.142.207.110]:1892 "HELO
	web32013.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S263187AbVGOFLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:11:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1k9UtbUA3eqMwqKrIciJCZZ2PSKb98vS4BXoPeXehCMP6BHOQkEkNLgiTBZ4vpyIjTrksjSPX6IANHODeRnmmEM2NghiUCk+eCEDfLT2ITf9ZYXTwL4+J3OPDHXBPdg5imRIRzdbhM9lFF05bdJUiIrWXryAL4SFWqmgCPpOYOw=  ;
Message-ID: <20050715051136.25530.qmail@web32013.mail.mud.yahoo.com>
Date: Thu, 14 Jul 2005 22:11:36 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050714114220.C31383@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-641718482-1121404296=:23392"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-641718482-1121404296=:23392
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> Well, in this case, the "whinging" resulted in
> finding a _real_ bug and locating why your ports 
> weren't being found.  So I guess it's
> good for something.

Indeed! The old kernel didn't have such an advantage.

> Can you mail me a diff of the changes you made to
> arch/ppc/platforms/sandpoint.h please?  

Certainly. 

> If that file is being used it seems that you 
> actually have 4 ports defined in total.  However,
> I'm a little confused because the sandpoint.h
> defines don't seem to match your original dmesg 
> output.

Well, I use a sandpoint-based board. Not the same as
the reference one. There are two serial ports on the
board and I enabled them both with IRQ9/10. 
In addition, No 8259 on this board.

Pls don't apply this patch:-)

Thanks,

Sam


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
--0-641718482-1121404296=:23392
Content-Type: application/octet-stream; name="sandpoint-8250.diff"
Content-Transfer-Encoding: base64
Content-Description: 2389572820-sandpoint-8250.diff
Content-Disposition: attachment; filename="sandpoint-8250.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xMy1yYzMvYXJjaC9wcGMvcGxhdGZvcm1z
L3NhbmRwb2ludC5jIGxpbnV4LTIuNi4xMy1yYzMtODI0MS9hcmNoL3BwYy9w
bGF0Zm9ybXMvc2FuZHBvaW50LmMKLS0tIGxpbnV4LTIuNi4xMy1yYzMvYXJj
aC9wcGMvcGxhdGZvcm1zL3NhbmRwb2ludC5jCTIwMDUtMDctMTMgMTI6NDY6
NDYuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTMtcmMzLTgyNDEv
YXJjaC9wcGMvcGxhdGZvcm1zL3NhbmRwb2ludC5jCTIwMDUtMDctMTUgMTI6
NTI6MDguMDAwMDAwMDAwICswODAwCkBAIC0zMjAsOSArMzIwLDggQEAKIAog
CQkJLyogdGhpcyBkaXNhYmxlcyB0aGUgMm5kIHNlcmlhbCBwb3J0IG9uIHRo
ZSBEVUFSVAogCQkJICogc2luY2UgdGhlIHNhbmRwb2ludCBkb2VzIG5vdCBo
YXZlIGl0IGNvbm5lY3RlZCAqLwotCQkJcGRhdGFbMV0udWFydGNsayA9IDA7
Ci0JCQlwZGF0YVsxXS5pcnEgPSAwOwotCQkJcGRhdGFbMV0ubWFwYmFzZSA9
IDA7CisJCQlwZGF0YVsxXS51YXJ0Y2xrID0gYnAtPmJpX2J1c2ZyZXE7CisJ
CQlwZGF0YVsxXS5tZW1iYXNlID0gaW9yZW1hcChwZGF0YVsxXS5tYXBiYXNl
LCAweDEwMCk7CiAJCX0KIAl9CiAKZGlmZiAtdXJOIGxpbnV4LTIuNi4xMy1y
YzMvYXJjaC9wcGMvcGxhdGZvcm1zL3NhbmRwb2ludC5oIGxpbnV4LTIuNi4x
My1yYzMtODI0MS9hcmNoL3BwYy9wbGF0Zm9ybXMvc2FuZHBvaW50LmgKLS0t
IGxpbnV4LTIuNi4xMy1yYzMvYXJjaC9wcGMvcGxhdGZvcm1zL3NhbmRwb2lu
dC5oCTIwMDUtMDctMTMgMTI6NDY6NDYuMDAwMDAwMDAwICswODAwCisrKyBs
aW51eC0yLjYuMTMtcmMzLTgyNDEvYXJjaC9wcGMvcGxhdGZvcm1zL3NhbmRw
b2ludC5oCTIwMDUtMDctMTUgMTI6NDU6MTQuMDAwMDAwMDAwICswODAwCkBA
IC01MSwzMCArNTEsMTMgQEAKIC8qCiAgKiBTZXJpYWwgZGVmaW5lcy4KICAq
LwotI2RlZmluZSBTQU5EUE9JTlRfU0VSSUFMXzAJCTB4ZmUwMDAzZjgKLSNk
ZWZpbmUgU0FORFBPSU5UX1NFUklBTF8xCQkweGZlMDAwMmY4Ci0KLSNkZWZp
bmUgUlNfVEFCTEVfU0laRSAgMgotCisjZGVmaW5lIFJTX1RBQkxFX1NJWkUg
IDQKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAvKiBS
YXRlIGZvciB0aGUgMS44NDMyIE1oeiBjbG9jayBmb3IgdGhlIG9uYm9hcmQg
c2VyaWFsIGNoaXAgKi8KLSNkZWZpbmUgQkFTRV9CQVVECQkJKCAxODQzMjAw
IC8gMTYgKQotI2RlZmluZSBVQVJUX0NMSwkJCTE4NDMyMDAKLQotI2lmZGVm
IENPTkZJR19TRVJJQUxfREVURUNUX0lSUQotI2RlZmluZSBTVERfQ09NX0ZM
QUdTIChBU1lOQ19CT09UX0FVVE9DT05GfEFTWU5DX0FVVE9fSVJRKQotI2Vs
c2UKLSNkZWZpbmUgU1REX0NPTV9GTEFHUyAoQVNZTkNfQk9PVF9BVVRPQ09O
RikKLSNlbmRpZgotCi0jZGVmaW5lIFNURF9TRVJJQUxfUE9SVF9ERk5TIFwK
LSAgICAgICAgeyAwLCBCQVNFX0JBVUQsIFNBTkRQT0lOVF9TRVJJQUxfMCwg
NCwgU1REX0NPTV9GTEFHUywgLyogdHR5UzAgKi8gXAotCQlpb21lbV9iYXNl
OiAodTggKilTQU5EUE9JTlRfU0VSSUFMXzAsCQkJICBcCi0JCWlvX3R5cGU6
IFNFUklBTF9JT19NRU0gfSwJCQkJICBcCi0gICAgICAgIHsgMCwgQkFTRV9C
QVVELCBTQU5EUE9JTlRfU0VSSUFMXzEsIDMsIFNURF9DT01fRkxBR1MsIC8q
IHR0eVMxICovIFwKLQkJaW9tZW1fYmFzZTogKHU4ICopU0FORFBPSU5UX1NF
UklBTF8xLAkJCSAgXAotCQlpb190eXBlOiBTRVJJQUxfSU9fTUVNIH0sCi0K
LSNkZWZpbmUgU0VSSUFMX1BPUlRfREZOUyBcCi0gICAgICAgIFNURF9TRVJJ
QUxfUE9SVF9ERk5TCisjZGVmaW5lIEJBU0VfQkFVRCAgICAgICAgICAgICAg
ICAgICAgICAgKCAxMDAwMDAwMDAgLyAxNiApIC8qIDEwME1oeiBzcGVlZCwg
ZGl2aWRlZCBieSAxNgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB0byBtYWtlIHRoZSBv
dXRwdXQgZnJlcWVuY3kgKi8KKyNkZWZpbmUgVUFSVF9DTEsgICAgICAgICAg
ICAgICAgICAgICAgICAxODQzMjAwCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAorI2RlZmluZSBTVERfQ09NX0ZMQUdTIChBU1lOQ19C
T09UX0FVVE9DT05GfEFTWU5DX1NLSVBfVEVTVCkKIAogI2VuZGlmIC8qIF9f
UFBDX1BMQVRGT1JNU19TQU5EUE9JTlRfSCAqLwpkaWZmIC11ck4gbGludXgt
Mi42LjEzLXJjMy9hcmNoL3BwYy9zeXNsaWIvbXBjMTB4X2NvbW1vbi5jIGxp
bnV4LTIuNi4xMy1yYzMtODI0MS9hcmNoL3BwYy9zeXNsaWIvbXBjMTB4X2Nv
bW1vbi5jCi0tLSBsaW51eC0yLjYuMTMtcmMzL2FyY2gvcHBjL3N5c2xpYi9t
cGMxMHhfY29tbW9uLmMJMjAwNS0wNy0xMyAxMjo0Njo0Ni4wMDAwMDAwMDAg
KzA4MDAKKysrIGxpbnV4LTIuNi4xMy1yYzMtODI0MS9hcmNoL3BwYy9zeXNs
aWIvbXBjMTB4X2NvbW1vbi5jCTIwMDUtMDctMTUgMTI6NTA6MzkuMDAwMDAw
MDAwICswODAwCkBAIC00MSwxMCArNDEsMTAgQEAKICNlbHNlCiAjZGVmaW5l
IEVQSUNfSVJRX0JBU0UgNQogI2VuZGlmCi0jZGVmaW5lIE1QQzEwWF9JMkNf
SVJRIChFUElDX0lSUV9CQVNFICsgTlVNXzgyNTlfSU5URVJSVVBUUykKLSNk
ZWZpbmUgTVBDMTBYX0RNQTBfSVJRIChFUElDX0lSUV9CQVNFICsgMSArIE5V
TV84MjU5X0lOVEVSUlVQVFMpCi0jZGVmaW5lIE1QQzEwWF9ETUExX0lSUSAo
RVBJQ19JUlFfQkFTRSArIDIgKyBOVU1fODI1OV9JTlRFUlJVUFRTKQotI2Rl
ZmluZSBNUEMxMFhfVUFSVDBfSVJRIChFUElDX0lSUV9CQVNFICsgNCArIE5V
TV84MjU5X0lOVEVSUlVQVFMpCisjZGVmaW5lIE1QQzEwWF9JMkNfSVJRIChF
UElDX0lSUV9CQVNFKQorI2RlZmluZSBNUEMxMFhfRE1BMF9JUlEgKEVQSUNf
SVJRX0JBU0UgKyAxKQorI2RlZmluZSBNUEMxMFhfRE1BMV9JUlEgKEVQSUNf
SVJRX0JBU0UgKyAyKQorI2RlZmluZSBNUEMxMFhfVUFSVDBfSVJRIChFUElD
X0lSUV9CQVNFICsgNCkKICNlbHNlCiAjZGVmaW5lIE1QQzEwWF9JMkNfSVJR
IC0xCiAjZGVmaW5lIE1QQzEwWF9ETUEwX0lSUSAtMQo=

--0-641718482-1121404296=:23392--
