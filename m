Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVFWRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVFWRdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVFWRdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:33:44 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:7886 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262613AbVFWR2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:28:13 -0400
Date: Thu, 23 Jun 2005 10:27:53 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?TWljaGFfXw==?= Piotrowski 
	<piotrowskim@trex.wsi.edu.pl>
Cc: paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Script to help users to report a BUG
Message-Id: <20050623102753.69c63d48.rdunlap@xenotime.net>
In-Reply-To: <42BAA5C2.7060906@trex.wsi.edu.pl>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
	<4d8e3fd30506200027686cbafa@mail.gmail.com>
	<42B6D74B.3020409@trex.wsi.edu.pl>
	<4d8e3fd30506201322242d540a@mail.gmail.com>
	<4d8e3fd305062205371b0a506d@mail.gmail.com>
	<42B951B4.80703@trex.wsi.edu.pl>
	<4d8e3fd30506220656241e1521@mail.gmail.com>
	<42B9544E.7030007@trex.wsi.edu.pl>
	<4d8e3fd305062212343d9849ee@mail.gmail.com>
	<42B9D391.4020602@trex.wsi.edu.pl>
	<4d8e3fd305062300541eca2c10@mail.gmail.com>
	<42BAA5C2.7060906@trex.wsi.edu.pl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__23_Jun_2005_10_27_53_-0700_LKsYzv+Rb=ndoU+X"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__23_Jun_2005_10_27_53_-0700_LKsYzv+Rb=ndoU+X
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jun 2005 14:06:26 +0200 Micha__ Piotrowski wrote:

| Hi,
|=20
| Here is new "big" version:
| http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a7.tar.bz2
|=20
| Changes... You will see ;).
|=20
| Todo:
| raport sending!!!
|=20
| Thans for patches.

Here are more comments and a patch for you (attached).

ver. a7:

output file with '/' didn't work for me; changed to hyphens;
just one one tmp file name (not several p?.txt);
write the input TXT lines to the temp file before calling editor;
remove the tmp file at end;

I think that the editor and email client Q&A is overkill.

---
~Randy

--Multipart=_Thu__23_Jun_2005_10_27_53_-0700_LKsYzv+Rb=ndoU+X
Content-Type: application/octet-stream;
 name="ort.sh.a7.patch"
Content-Disposition: attachment;
 filename="ort.sh.a7.patch"
Content-Transfer-Encoding: base64

LS0tIG9ydC5zaC5hNwkyMDA1LTA2LTIzIDA0OjU5OjI5LjAwMDAwMDAwMCAtMDcwMAorKysgb3J0
LnNoCTIwMDUtMDYtMjMgMTA6MTQ6MzMuMDAwMDAwMDAwIC0wNzAwCkBAIC0xNiw3ICsxNiw3IEBA
CiAjIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNv
ZnR3YXJlCiAjIEZvdW5kYXRpb24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBC
b3N0b24sIE1BICAwMjExMS0xMzA3ICBVU0EKIAkJCSAgICAKLU9SVF9GPW9ydF9vb3BzLWBkYXRl
ICsleGAudHh0CitPUlRfRj1vcnRfb29wcy1gZGF0ZSArJUZgLnR4dAogVkVSPXYuYTcKIAogTV9F
TUFJTD1hQGIuYwpAQCAtMTI4LDkgKzEyOCw5IEBACiAgICAgZG9uZQogfQogCi1pZiBbWyAtZiBw
Py50eHQgXV0KK2lmIFtbIC1mIG9ydG1wLnR4dCBdXQogICAgIHRoZW4KLQlybSBwPy50eHQKKwly
bSBvcnRtcC50eHQKIGZpCiAKIGlmIFtbIC16ICIkMSIgfHwgIiQxIiA9ICItLWhlbHAiIF1dCkBA
IC0xNTQsMjEgKzE1NCwyNCBAQAogZWNobyAiWzEuXSBPbmUgbGluZSBzdW1tYXJ5IG9mIHRoZSBw
cm9ibGVtOiAocHJlc3MgUmV0dXJuIHRvIGNvbnRpbnVlKSIKIGVjaG8gLWUgIlxuWzEuXSBPbmUg
bGluZSBzdW1tYXJ5IG9mIHRoZSBwcm9ibGVtOiIgPj4gJE9SVF9GCiByZWFkIFRYVAotJEVESVRP
UiBwMS50eHQKLWNhdCBwMS50eHQgPj4gJE9SVF9GCitlY2hvICRUWFQgPiBvcnRtcC50eHQKKyRF
RElUT1Igb3J0bXAudHh0CitjYXQgb3J0bXAudHh0ID4+ICRPUlRfRgogCiBlY2hvICJbMi5dIEZ1
bGwgZGVzY3JpcHRpb24gb2YgdGhlIHByb2JsZW0vcmVwb3J0OiAocHJlc3MgUmV0dXJuIHRvIGNv
bnRpbnVlKSIKIGVjaG8gLWUgIlxuWzIuXSBGdWxsIGRlc2NyaXB0aW9uIG9mIHRoZSBwcm9ibGVt
L3JlcG9ydDoiID4+ICRPUlRfRgogcmVhZCBUWFQKLSRFRElUT1IgcDIudHh0Ci1jYXQgcDIudHh0
ID4+ICRPUlRfRgorZWNobyAkVFhUID4gb3J0bXAudHh0CiskRURJVE9SIG9ydG1wLnR4dAorY2F0
IG9ydG1wLnR4dCA+PiAkT1JUX0YKIAogZWNobyAiWzMuXSBLZXl3b3JkcyAoaS5lLiwgbW9kdWxl
cywgbmV0d29ya2luZywga2VybmVsKTogKHByZXNzIFJldHVybiB0byBjb250aW51ZSkiCiBlY2hv
IC1lICJcblszLl0gS2V5d29yZHMgKGkuZS4sIG1vZHVsZXMsIG5ldHdvcmtpbmcsIGtlcm5lbCk6
IiA+PiAkT1JUX0YKIHJlYWQgVFhUCitlY2hvICRUWFQgPiBvcnRtcC50eHQKICNUT1BJQz0kVFhU
Ci0kRURJVE9SIHAzLnR4dAotY2F0IHAzLnR4dCA+PiAkT1JUX0YKKyRFRElUT1Igb3J0bXAudHh0
CitjYXQgb3J0bXAudHh0ID4+ICRPUlRfRgogCiBlY2hvIC1lICJcbls0Ll0gS2VybmVsIHZlcnNp
b24gKGZyb20gL3Byb2MvdmVyc2lvbik6IiA+PiAkT1JUX0YKIGNhdCAvcHJvYy92ZXJzaW9uID4+
ICRPUlRfRgpAQCAtMTc5LDggKzE4Miw5IEBACiBlY2hvIC1lICJcbls2Ll0gQSBzbWFsbCBzaGVs
bCBzY3JpcHQgb3IgZXhhbXBsZSBwcm9ncmFtIHdoaWNoIHRyaWdnZXJzIHRoZSBwcm9ibGVtIChp
ZiBwb3NzaWJsZSk6IChwcmVzcyBSZXR1cm4gdG8gY29udGludWUpIgogZWNobyAtZSAiXG5bNi5d
IEEgc21hbGwgc2hlbGwgc2NyaXB0IG9yIGV4YW1wbGUgcHJvZ3JhbSB3aGljaCB0cmlnZ2VycyB0
aGUgcHJvYmxlbSAoaWYgcG9zc2libGUpOiIgPj4gJE9SVF9GCiByZWFkIFRYVAotJEVESVRPUiBw
Ni50eHQKLWNhdCBwNi50eHQgPj4gJE9SVF9GCitlY2hvICRUWFQgPiBvcnRtcC50eHQKKyRFRElU
T1Igb3J0bXAudHh0CitjYXQgb3J0bXAudHh0ID4+ICRPUlRfRgogCiBlY2hvIC1lICJcbls3Ll0g
RW52aXJvbm1lbnQiID4+ICRPUlRfRgogCkBAIC0yNzYsOCArMjgwLDE0IEBACiBlY2hvIC1lICJc
bls5Ll0gT3RoZXIgbm90ZXMsIHBhdGNoZXMsIGZpeGVzLCB3b3JrYXJvdW5kczogKHByZXNzIFJl
dHVybiB0byBjb250aW51ZSkiCiBlY2hvIC1lICJcbls5Ll0gT3RoZXIgbm90ZXMsIHBhdGNoZXMs
IGZpeGVzLCB3b3JrYXJvdW5kczoiID4+ICRPUlRfRgogcmVhZCBUWFQKLSRFRElUT1IgcDkudHh0
Ci1jYXQgcDkudHh0ID4+ICRPUlRfRgorZWNobyAkVFhUID4gb3J0bXAudHh0CiskRURJVE9SIG9y
dG1wLnR4dAorY2F0IG9ydG1wLnR4dCA+PiAkT1JUX0YKKworaWYgW1sgLWYgb3J0bXAudHh0IF1d
CisgICAgdGhlbgorCXJtIG9ydG1wLnR4dAorZmkKIAogRU5EPTAKIHdoaWxlIFsgJEVORCA9IDAg
XQpAQCAtMzQ1LDggKzM1NSw4IEBACiAJICAgIGRvbmUJICAgIAogICAgIGVsaWYgWyAkVFhUID0g
Ik4iIF0gfHwgWyAkVFhUID0gIm4iIF0KIAl0aGVuCi0JICAgIGVjaG8gLWUgIlxuUGxlYXNlIGVt
YWlsICRPUlRfRiB0byBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIG9yICIKLQkgICAgZWNo
byAtZSAic29tZSBvdGhlciBhcHByb3ByaWF0ZSBMaW51eCBtYWlsaW5nIGxpc3QuIgorCSAgICBl
Y2hvIC1lICJcblBsZWFzZSBlbWFpbCAkT1JUX0YgdG8gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZyAiCisJICAgIGVjaG8gLWUgIm9yIHNvbWUgb3RoZXIgYXBwcm9wcmlhdGUgTGludXggbWFp
bGluZyBsaXN0LiIKIAkgICAgRU5EPTEKICAgICBmaQotZG9uZQpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUKK2RvbmUK

--Multipart=_Thu__23_Jun_2005_10_27_53_-0700_LKsYzv+Rb=ndoU+X--
