Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSLQT2g>; Tue, 17 Dec 2002 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbSLQT2g>; Tue, 17 Dec 2002 14:28:36 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:455 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266637AbSLQT2d>; Tue, 17 Dec 2002 14:28:33 -0500
Date: Wed, 18 Dec 2002 08:35:22 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: "O.Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
cc: zander@minion.de
Subject: Re: rmap and nvidia?
Message-ID: <49770000.1040153722@localhost.localdomain>
In-Reply-To: <3DFE522A.6010803@superonline.com>
References: <3DFE522A.6010803@superonline.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1854059384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1854059384==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So, first apply the patch for 4191 from www.minion.de, then the attached 
one based on yours.  Been running overnight and beaten on by XScreesaver, 
no memory leak anymore.

Andrew

--On Tuesday, December 17, 2002 00:22:34 +0200 "O.Sezer" 
<sezero@superonline.com> wrote:

> Is this patch correct in any way?
> (Ripped out of the 2.5 patch and modified some).
>
> Thanks.
>


--==========1854059384==========
Content-Type: application/octet-stream;
 name="NVIDIA_kernel-1.0-4191-2.5-pte_unmap.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="NVIDIA_kernel-1.0-4191-2.5-pte_unmap.diff"; size=1607

LS0tIE5WSURJQV9rZXJuZWwtMS4wLTQxOTEtMi41LW1pbmlvbi9udi1saW51eC5oCTIwMDItMTIt
MTggMDg6MjU6NTAuMDAwMDAwMDAwICsxMzAwCisrKyBOVklESUFfa2VybmVsLTEuMC00MTkxLTIu
NS9udi1saW51eC5oCTIwMDItMTItMTcgMjI6MDM6MzEuMDAwMDAwMDAwICsxMzAwCkBAIC0xNTEs
MjEgKzE1MSwyNyBAQAogIyAgZGVmaW5lIFNNUF9OVU1fQ1BVUyAgICAgICAgICAgICAgICAgIHNt
cF9udW1fY3B1cwogI2VuZGlmCiAKLSNpZmRlZiBLRVJORUxfMl81Ci0jZGVmaW5lIFBURV9PRkZT
RVQocG1kLCBhZGRyZXNzLCBwdGUpICAgKHB0ZSA9ICpwdGVfb2Zmc2V0X21hcChwbWQsIGFkZHJl
c3MpKQorI2lmZGVmIHB0ZV9vZmZzZXRfbWFwCQkvKiBybWFwLXZtIG9yIDIuNSAgKi8KKyNkZWZp
bmUgUFRFX09GRlNFVChwbWQsIGFkZHJlc3MsIHB0ZSkgICAgICAgICAgICAgICBcCisgeyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICBwdGVf
dCAqcFBURTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgcFBURSA9
IHB0ZV9vZmZzZXRfbWFwKHBtZCwgYWRkcmVzcyk7ICAgICAgICAgICBcCisgICAgIHB0ZSA9ICpw
UFRFOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICBwdGVfdW5tYXAo
cFBURSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyB9CiAjZWxzZQotI2lmZGVm
IHB0ZV9vZmZzZXRfYXRvbWljCisjaWZkZWYgcHRlX29mZnNldF9hdG9taWMJCS8qIGFhLXZtICAg
Ki8KICNkZWZpbmUgUFRFX09GRlNFVChwbWQsIGFkZHJlc3MsIHB0ZSkgICAgICAgICAgICAgICBc
Ci0gIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
KyAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAg
ICAgIHB0ZV90ICpwUFRFOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAg
ICBwUFRFID0gcHRlX29mZnNldF9hdG9taWMocG1kLCBhZGRyZXNzKTsgICAgICAgIFwKICAgICAg
cHRlID0gKnBQVEU7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgIHB0
ZV9rdW5tYXAocFBURSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICB9Ci0jZWxz
ZSAvKiAhcHRlX29mZnNldF9hdG9taWMgKi8KKyNlbHNlCS8qICFwdGVfb2Zmc2V0X2F0b21pYyAq
LwogI2RlZmluZSBQVEVfT0ZGU0VUKHBtZCwgYWRkcmVzcywgcHRlKSAgIChwdGUgPSAqcHRlX29m
ZnNldChwbWQsIGFkZHJlc3MpKQotI2VuZGlmIC8qIHB0ZV9vZmZzZXRfYXRvbWljICovCi0jZW5k
aWYgLyogS0VSTkVMXzJfNSAqLworI2VuZGlmCS8qIHB0ZV9vZmZzZXRfYXRvbWljICAqLworI2Vu
ZGlmCS8qIHB0ZV9vZmZzZXRfbWFwICAgICAqLwogCiAjZGVmaW5lIE5WX1BBR0VfQUxJR04oYWRk
cikgICAgICAgICAgICAgKCAoKGFkZHIpICsgUEFHRV9TSVpFIC0gMSkgLyBQQUdFX1NJWkUpCiAj
ZGVmaW5lIE5WX01BU0tfT0ZGU0VUKGFkZHIpICAgICAgICAgICAgKCAoYWRkcikgJiAoUEFHRV9T
SVpFIC0gMSkgKQo=

--==========1854059384==========--

