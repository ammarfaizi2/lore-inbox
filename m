Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVA0Q6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVA0Q6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVA0Q5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:57:54 -0500
Received: from web88003.mail.re2.yahoo.com ([206.190.37.190]:44889 "HELO
	web88003.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262665AbVA0Q4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:56:47 -0500
Message-ID: <20050127165646.97935.qmail@web88003.mail.re2.yahoo.com>
Date: Thu, 27 Jan 2005 11:56:46 -0500 (EST)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement - 
To: Greg KH <greg@kroah.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050127090358.GC1528@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1944357630-1106845006=:97864"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1944357630-1106845006=:97864
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Description: Cleanup some cluttered macros, add error
checking for fan divisor value set.

Approved-by: Greg KH <greg@kroah.com>
Signed-off-by: Sytse Wielinga
<s.b.wielinga@student.utwente.nl>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

 --- Greg KH <greg@kroah.com> wrote: 
> On Wed, Jan 26, 2005 at 12:31:30PM -0500, Shawn
> Starr wrote:
> > Here is the corrected fix, yeah that didn't make
> > sense.   
> > 3AM isn't a good time to send patches I guess :-)
> 
> Care to resend it, with a full description and a
> Signed-off-by: line so
> I can apply it?
> 
> thanks,
> 
> greg k-h
>  
--0-1944357630-1106845006=:97864
Content-Type: application/octet-stream; name="lm80-fixup-3.diff"
Content-Transfer-Encoding: base64
Content-Description: lm80-fixup-3.diff
Content-Disposition: attachment; filename="lm80-fixup-3.diff"

CkRlc2NyaXB0aW9uOiBDbGVhbnVwIHNvbWUgY2x1dHRlcmVkIG1hY3Jvcywg
YWRkIGVycm9yIGNoZWNraW5nIGZvciBmYW4gZGl2aXNvciB2YWx1ZSBzZXQu
CgpBcHByb3ZlZC1ieTogR3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+ClNpZ25l
ZC1vZmYtYnk6IFN5dHNlIFdpZWxpbmdhIDxzLmIud2llbGluZ2FAc3R1ZGVu
dC51dHdlbnRlLm5sPgpTaWduZWQtb2ZmLWJ5OiBBdXJlbGllbiBKYXJubyA8
YXVyZWxpZW5AYXVyZWwzMi5uZXQ+ClNpZ25lZC1vZmYtYnk6IFNoYXduIFN0
YXJyIDxzaGF3bi5zdGFyckByb2dlcnMuY29tPgoKLS0tIGxpbnV4LTIuNi4x
MS1yYzIvZHJpdmVycy9pMmMvY2hpcHMvbG04MC5jCTIwMDUtMDEtMjYgMDI6
MDQ6MzguMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTEtcmMyLWZp
eGVzL2RyaXZlcnMvaTJjL2NoaXBzL2xtODAuYwkyMDA1LTAxLTI2IDEyOjMx
OjI2LjAwMDAwMDAwMCAtMDUwMApAQCAtOTksMTAgKzk5LDcgQEAgc3RhdGlj
IGlubGluZSBsb25nIFRFTVBfRlJPTV9SRUcodTE2IHRlbQogI2RlZmluZSBU
RU1QX0xJTUlUX1RPX1JFRyh2YWwpCQlTRU5TT1JTX0xJTUlUKCh2YWwpPDA/
XAogCQkJCQkoKHZhbCktNTAwKS8xMDAwOigodmFsKSs1MDApLzEwMDAsMCwy
NTUpCiAKLSNkZWZpbmUgQUxBUk1TX0ZST01fUkVHKHZhbCkJCSh2YWwpCi0K
ICNkZWZpbmUgRElWX0ZST01fUkVHKHZhbCkJCSgxIDw8ICh2YWwpKQotI2Rl
ZmluZSBESVZfVE9fUkVHKHZhbCkJCQkoKHZhbCk9PTg/MzoodmFsKT09ND8y
Oih2YWwpPT0xPzA6MSkKIAogLyoKICAqIENsaWVudCBkYXRhIChlYWNoIGNs
aWVudCBnZXRzIGl0cyBvd24pCkBAIC0yNjksNyArMjY2LDE3IEBAIHN0YXRp
YyBzc2l6ZV90IHNldF9mYW5fZGl2KHN0cnVjdCBkZXZpY2UKIAkJCSAgIERJ
Vl9GUk9NX1JFRyhkYXRhLT5mYW5fZGl2W25yXSkpOwogCiAJdmFsID0gc2lt
cGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7Ci0JZGF0YS0+ZmFuX2Rpdltu
cl0gPSBESVZfVE9fUkVHKHZhbCk7CisKKwlzd2l0Y2ggKHZhbCkgeworCWNh
c2UgMTogZGF0YS0+ZmFuX2Rpdltucl0gPSAwOyBicmVhazsKKwljYXNlIDI6
IGRhdGEtPmZhbl9kaXZbbnJdID0gMTsgYnJlYWs7CisJY2FzZSA0OiBkYXRh
LT5mYW5fZGl2W25yXSA9IDI7IGJyZWFrOworCWNhc2UgODogZGF0YS0+ZmFu
X2Rpdltucl0gPSAzOyBicmVhazsKKwlkZWZhdWx0OgorCQlkZXZfZXJyKCZj
bGllbnQtPmRldiwgImZhbl9kaXYgdmFsdWUgJWxkIG5vdCAiCisJCQkic3Vw
cG9ydGVkLiBDaG9vc2Ugb25lIG9mIDEsIDIsIDQgb3IgOCFcbiIsIHZhbCk7
CisJCXJldHVybiAtRUlOVkFMOworCX0KIAogCXJlZyA9IChsbTgwX3JlYWRf
dmFsdWUoY2xpZW50LCBMTTgwX1JFR19GQU5ESVYpICYgfigzIDw8ICgyICog
KG5yICsgMSkpKSkKIAkgICAgfCAoZGF0YS0+ZmFuX2Rpdltucl0gPDwgKDIg
KiAobnIgKyAxKSkpOwpAQCAtMzI3LDcgKzMzNCw3IEBAIHNldF90ZW1wKG9z
X2h5c3QsIHRlbXBfb3NfaHlzdCwgTE04MF9SRUcKIHN0YXRpYyBzc2l6ZV90
IHNob3dfYWxhcm1zKHN0cnVjdCBkZXZpY2UgKmRldiwgY2hhciAqYnVmKQog
ewogCXN0cnVjdCBsbTgwX2RhdGEgKmRhdGEgPSBsbTgwX3VwZGF0ZV9kZXZp
Y2UoZGV2KTsKLQlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgQUxBUk1T
X0ZST01fUkVHKGRhdGEtPmFsYXJtcykpOworCXJldHVybiBzcHJpbnRmKGJ1
ZiwgIiV1XG4iLCBkYXRhLT5hbGFybXMpOwogfQogCiBzdGF0aWMgREVWSUNF
X0FUVFIoaW4wX21pbiwgU19JV1VTUiB8IFNfSVJVR08sIHNob3dfaW5fbWlu
MCwgc2V0X2luX21pbjApOwo=

--0-1944357630-1106845006=:97864--
