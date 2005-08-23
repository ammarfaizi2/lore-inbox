Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVHWPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVHWPQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVHWPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:16:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45996 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932196AbVHWPQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:16:47 -0400
Message-ID: <430B3D73.8080807@us.ibm.com>
Date: Tue, 23 Aug 2005 10:14:59 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matthew Wilcox <matthew@wil.cx>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2/2] ipr: Block config access during BIST (resend)
References: <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk> <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk> <4200F2B2.3080306@us.ibm.com> <20050208200816.GA25292@kroah.com> <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com>
In-Reply-To: <430B3CB4.1050105@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020504070705010907000304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020504070705010907000304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg,

Please apply along with the previous pci patch.

Thanks

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------020504070705010907000304
Content-Type: text/plain;
 name="ipr_block_user_config_io_during_bist.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ipr_block_user_config_io_during_bist.patch"

CklQUiBzY3NpIGFkYXB0ZXIgaGF2ZSBhbiBleHBvc3VyZSB0b2RheSBpbiB0aGF0ICB0aGV5
IGlzc3VlIEJJU1QgdG8KdGhlIGFkYXB0ZXIgdG8gcmVzZXQgdGhlIGNhcmQuIElmLCBkdXJp
bmcgdGhlIHRpbWUgaXQgdGFrZXMgdG8gY29tcGxldGUKQklTVCwgdXNlcnNwYWNlIGF0dGVt
cHRzIHRvIGFjY2VzcyBQQ0kgY29uZmlnIHNwYWNlLCB0aGUgaG9zdCBidXMgYnJpZGdlCndp
bGwgbWFzdGVyIGFib3J0IHRoZSBhY2Nlc3Mgc2luY2UgdGhlIGlwciBhZGFwdGVyIGRvZXMg
bm90IHJlc3BvbmQgb24KdGhlIFBDSSBidXMgZm9yIGEgYnJpZWYgcGVyaW9kIG9mIHRpbWUg
d2hlbiBydW5uaW5nIEJJU1QuIE9uIFBQQzY0CmhhcmR3YXJlLCB0aGlzIG1hc3RlciBhYm9y
dCByZXN1bHRzIGluIHRoZSBob3N0IFBDSSBicmlkZ2UgaXNvbGF0aW5nCnRoYXQgUENJIGRl
dmljZSBmcm9tIHRoZSByZXN0IG9mIHRoZSBzeXN0ZW0sIG1ha2luZyB0aGUgZGV2aWNlIHVu
dXNhYmxlCnVudGlsIExpbnV4IGlzIHJlYm9vdGVkLiBUaGlzIHBhdGNoIG1ha2VzIHVzZSBv
ZiBzb21lIG5ld2x5IGFkZGVkIFBDSSBsYXllcgpBUElzIHRoYXQgYWxsb3cgZm9yIHByb3Rl
Y3Rpb24gZnJvbSB1c2Vyc3BhY2UgYWNjZXNzaW5nIGNvbmZpZyBzcGFjZQpvZiBhIGRldmlj
ZSBpbiBzY2VuYXJpb3Mgc3VjaCBhcyB0aGlzLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gS2lu
ZyA8YnJraW5nQHVzLmlibS5jb20+Ci0tLQoKIGxpbnV4LTIuNi1iamtpbmcxL2RyaXZlcnMv
c2NzaS9pcHIuYyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
CgpkaWZmIC1wdU4gZHJpdmVycy9zY3NpL2lwci5jfmlwcl9ibG9ja191c2VyX2NvbmZpZ19p
b19kdXJpbmdfYmlzdCBkcml2ZXJzL3Njc2kvaXByLmMKLS0tIGxpbnV4LTIuNi9kcml2ZXJz
L3Njc2kvaXByLmN+aXByX2Jsb2NrX3VzZXJfY29uZmlnX2lvX2R1cmluZ19iaXN0CTIwMDUt
MDgtMjIgMTc6MDM6NTcuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYtYmpraW5nMS9k
cml2ZXJzL3Njc2kvaXByLmMJMjAwNS0wOC0yMiAxNzowMzo1Ny4wMDAwMDAwMDAgLTA1MDAK
QEAgLTQ5NDQsNiArNDk0NCw3IEBAIHN0YXRpYyBpbnQgaXByX3Jlc2V0X3Jlc3RvcmVfY2Zn
X3NwYWNlKHMKIAlpbnQgcmM7CiAKIAlFTlRFUjsKKwlwY2lfdW5ibG9ja191c2VyX2NmZ19h
Y2Nlc3MoaW9hX2NmZy0+cGRldik7CiAJcmMgPSBwY2lfcmVzdG9yZV9zdGF0ZShpb2FfY2Zn
LT5wZGV2KTsKIAogCWlmIChyYyAhPSBQQ0lCSU9TX1NVQ0NFU1NGVUwpIHsKQEAgLTQ5OTgs
NiArNDk5OSw3IEBAIHN0YXRpYyBpbnQgaXByX3Jlc2V0X3N0YXJ0X2Jpc3Qoc3RydWN0IGkK
IAlpbnQgcmM7CiAKIAlFTlRFUjsKKwlwY2lfYmxvY2tfdXNlcl9jZmdfYWNjZXNzKGlvYV9j
ZmctPnBkZXYpOwogCXJjID0gcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGlvYV9jZmctPnBkZXYs
IFBDSV9CSVNULCBQQ0lfQklTVF9TVEFSVCk7CiAKIAlpZiAocmMgIT0gUENJQklPU19TVUND
RVNTRlVMKSB7Cl8K
--------------020504070705010907000304--
