Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbTCGDCh>; Thu, 6 Mar 2003 22:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbTCGDCh>; Thu, 6 Mar 2003 22:02:37 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:963 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S261492AbTCGDBS>;
	Thu, 6 Mar 2003 22:01:18 -0500
Date: Fri, 7 Mar 2003 04:11:50 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] i386-arch fixes/enhancements
Message-ID: <20030307031150.GA19889@werewolf.able.es>
References: <20030307030858.GA19479@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030307030858.GA19479@werewolf.able.es>; from jamagallon@able.es on Fri, Mar 07, 2003 at 04:08:58 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 03.07 04:08, J.A. Magallon wrote:
> Hi all...
> 
> This is  set of small patches that allow a finer tuning of i386 arch, and fix a
> small bug:
> 
> - 20-x86-p4-prefetch: enables prefetch also for p4. This is a pending bug, IMHO.
> - 21-x86-pII: splits Pentium-II as a separate config option; yes some of us
>   still have oldies and would like a slightly better optimized kernel
> - 22-x86-check_gcc: use check_gcc also for Intel CPUs (like others already do)
>   to get better gcc flags.
> - 23-x86-mb: implement memory barriers with specific instructions in p3 and p4
>   (credits go to Zwane Mwaikambo <zwane@linux.realnet.co.sz>)
> 
> Could this ever get into mainline ? Perhaps the only questionable piece is
> the mb changes. How about next -pre ?
> 

Ooops. Here they go...


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-1mdk))

--NzB8fVQJ5HfG6fxh
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="20-x86-p4-prefetch.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWXgaBGIAACjfgAIwSH//0G/j3gCv999EMAEso2GppTaNTGiNPSaaAaAA2kbU
aNANVMZTTxRnqTENNNDI0aYTRkZDQEokZNTyRp6po0HqaB6nlAaDanlDNQoUsdumKctND0jp
2QgNYoZYUHM5VqbZhjR+U/7iXPkitfXMOd/cHmbZYrZdECGlVYlhTMqsCgn1neWF1egtKyVc
NZmLjsEYKXGY1ExqHingNJDSactHkhofgQpcDz0EQSOKQWA4jOJgJRtEk5DeTa9EpLuVmqq7
m1m+cVYjUVH0rSmN6j0wSKQShJ3lFKupSKacEx9ct5HacMjcXnO5/lOtpMYbxw5Po3DBjBQX
lWOQ8ohEURjPZortpUZyEiJJSIwePKaml+cl9mRVokTKJtMF1LA4/BthOYlB1KSBZwg+LUH1
i5mQYPtOhoHDAXOPVEKEJlWFoF8QWTBVqP4u5IpwoSDwNAjE

--NzB8fVQJ5HfG6fxh
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="21-x86-pII.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWT6HFXsAANTfgFIwVG//+m/v3s6//95gUANL2WhdgAYYpJkAaMmk0wTNIG0h
gjT0CYaAmEkinqjb1SfqmjBDJpiPU0AwgBoAABqZKaDEGg0xADQA0DEA0aAA5gCMExAMAmCa
MhoYBMEYmEUggJPTJpJ5CmgHo1GT1NMnqaPU9QH6p6j0RsCUUC6CwgY5II/aRtxpCYBUQT+y
Wta4yyIPOMj+sB/YZVmrs2Il66zjuSHYe4neo9h6HlCNVSEXUmBIE2GsDN8iB8Ci/aeccvQR
+ja7wsaj/v6nGERXU88Kw5kUQjJdoFEz2SgWEpgcE6y8sjBCnR1nw0gXS2ShZ8UkqkMy91Jy
j80ang00x8eggYIIhFVJFUy9eefOpzjDajCe3o9Uvb7oip95bBB1DNoDP4ibCMMhxgHFFUCn
OvpWLVq3VrU45wkKyKZmJwxW3mx5iw2FCkEyYSP+D0gzgYGB9g7B9/edQy8zYPSMmdxMZUeg
uHXgP5VG3CdT9jUqPrHaOy+sOhANmHcEwnt9MtMBwndJoW8Ry9FltpfdBL8/kdxDdjBhNlAc
xk3k0bi4uHfpMwpo0g+chcBoNgENFSwUR7oB8FktrbXQBEKQ4y+vnzOspJI6ywsmIaXcxEQK
SfMzMwgWEAnQYOKNIYjYy9kIopM3cqWup5y2urRUkVbiYBW4vVJ7YOuIiJSzlKUiJsjwWa5m
dYJ48jmMH/CSQMYdcWzW+kN5xxVIWKmKpv8TmLlrrBuNmMD74iUSiCIggyYI2FTF0c7z7nE3
HBdanm51k6JAm1Hx7TO4iE2o3kuEQSJbCgnsExPIfHv4h3PlyKmm4DuPBbih3nflyPsqxERE
Uce0CWUYNIGQnLkfAgSma9g3hh2xidapYfwcw6uhAXXbQoDJaJKD+luA/kg1OcPF3mrsxiNW
0brzQmJwMxqf3Cp6h+B0garxN5Ichg+KpYNrWZtKXUsJMoCc2YM0gkdi2SVJjYPYWASvgoQc
DEl8oEjRaasaax0mJoMLkaLLMqO2bU6hgeq3oILN1CkCRMT3VKKlVTIv4FQWoLyxjgZj/F3J
FOFCQPocVew=

--NzB8fVQJ5HfG6fxh
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="22-x86-check_gcc.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWVSgslAAAEPfgAIwRG//0muvzkCv/9ZAMAFMoAlJJ5I02KGgHqAAGhoAAMBo
AABoAAAAAAVJQQJtGpHkmg00D1BobTU9T1NNPUaUcaBISopUgkdxCfMXVrcJhBxCG0BwwFot
4nEzE2+jE2mBcvuJRzx7OzeWMHQy2mVmWl6z11Kk5dq7DS0vVavfp1pYp2sjpWsWClxoscRL
MZUKTyMM52FRFnfHTJHPJiYaxkrSrpCeowpdLqlmOtWjYVUyrKX00DYTsNrqfcXmJcnfPync
O4bh+E2WVvlWjw4KVsqXd7gnhOhLpwGE0y21ORY+hyaG4lpxOJ5JOo3Henim9e9x4prZk8j6
poSkpXWakMXEZ0zJ0amD/HvZzyXGlmWnOlTJE260ZHDUXsqTpc9plKZ9D/i7kinChIKlBZKA

--NzB8fVQJ5HfG6fxh
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="23-x86-mb.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYi+mEgAAOVfgEIwXn//+mvv38q//9/gUAN+c1gAAlhqaKaDIaNGJkA0NANN
A0AGgA0HNMjIZMENGEwRpo0YgaZMjAAEEpqNTU1HqaaehND1MgGgyaAAA0GQAc0yMhkwQ0YT
BGmjRiBpkyMAAQKokaBNT0TU9I1PKPUaeUepk0APFG1PEno0T0mlo3zr757NFUm7s+TlSwU8
nr4e1+s+jUzsydzO2wwy7r8YxhhxsdrZX67Oaai1w/TNgSMCT/Vh4mEdg9zGNNWEkrELwcDV
NZ0A7zEDbRHFhlnlBCCSQqoBkNUjguwkUFoZ+Mvz29jLez7AahK/8Y3Hf52VnCJE8LkThMH9
xgkSp0UFwhCRrvAKg28WoGhopA4M1VoaEzbYyJFxJMkhJkkhJEiJ0ERsBlZhyKwmZORV+ExH
IhikiUqRG7E6OeaV5CXOL3yJ+5+RgcHA1WenPzHUYvQ5/352mTN9CqxRqHqdTW8mupeScpsO
t8xacJrJPKsXIy3FhW+Z0+rB2qn8mjQmzDVkLccugtOfEq1+UoXsPt9cIXYld2Z4QLN2MvsR
gRham88XwVdKJjmjudLviEvY/N516D3XxHek9rliHs8FjU5OW1NKTKmhDrcDBQhkXKYsiFN7
tnwZ4NbSKz74mktU7YhgQmi8hOPwVxZKmjJWKNS1bMLfOWaN/SNd6ZiCpJHGweocC9SNqSVl
GSkDmR96PSjUjUi0jooiz/JemfEl1P6wovR3I7M4hetQ6Ip8VWGa2rFdSs/CkrHth4jxYJSk
ywPc1PYW9e/c2Sj4xddgk2oqRXglWCPfof9RlEZtkVOZZfjvcOdK+DXU8sJbZhvb+G5kvIUL
lkut5G2G1wuxo2mTdCxcvRiwWEN6/iTGsvTLPMlm30Nl1Ea0dOJxpowvJTxt5RcUR8tuFKa+
RZbOdNURjEYZ0VUpEslChCyJuUoWJRs0jNdchxo5b/NWpI3hh59FlQaRdqZnr0kVB7mmFlxJ
WiDTBO9pyJQSmed4M0nK9IQnnt0wAi7ZCBWVRAzs2FgmaM4I3TVZVRPEu3ma3drvLeJGJmSh
jsSjLJ/F3JFOFCQiL6YSAA==

--NzB8fVQJ5HfG6fxh--
