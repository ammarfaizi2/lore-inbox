Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTIEVhK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTIEVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:37:08 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:34269 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S263131AbTIEVgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:36:23 -0400
Date: Fri, 5 Sep 2003 23:37:21 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm6
Message-Id: <20030905233721.22df5c72.bonganilinux@mweb.co.za>
In-Reply-To: <20030905015927.472aa760.akpm@osdl.org>
References: <20030905015927.472aa760.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="og?rJmbR=.2+s=cv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--og?rJmbR=.2+s=cv
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__5_Sep_2003_23:37:21_+0200_0833e8d8"


--Multipart_Fri__5_Sep_2003_23:37:21_+0200_0833e8d8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2003 01:59:27 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/
> 
> 

8< snip

> 
> . Dropped out Nick's CPU scheduler changes, brought back Con's interactivity
>   work.
> 
>   We didn't get many reports from this in -mm5.  I'd prefer to stick with
>   Con's patches because they're tweaks, rather than fundamental changes and
>   they have had more testing and are more widely understood.
> 
>   But the performance regressions with specjbb and volanomark are a
>   problem.  We need to understand this and get it fixed up.
> 

This might be a good thing, I lost my keyboard on my work PC around lunch time but everything else seemed fine and I found the attached oops on my /var/log/message file after rebooting. I don't know how many were there because modprobe is too noisy ;( 

Nick: maybe you can take a look so log, I don't know how to reproduce it yet. This was on the 2.6.0-test4-mm5 kernel.

--Multipart_Fri__5_Sep_2003_23:37:21_+0200_0833e8d8
Content-Type: application/octet-stream;
 name="event.oops"
Content-Disposition: attachment;
 filename="event.oops"
Content-Transfer-Encoding: base64

VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNz
IDE1ZDhjMDQ2CiBwcmludGluZyBlaXA6CmMwNDYxNWQ4CipwZGUgPSAwMDAwMDAwMApPb3BzOiAw
MDAwIFsjMV0KUFJFRU1QVApDUFU6ICAgIDAKRUlQOiAgICAwMDYwOltwZXJfY3B1X190dmVjX2Jh
c2VzKzg1Ni80MTA0XSAgICBOb3QgdGFpbnRlZCBWTEkKRUlQOiAgICAwMDYwOls8YzA0NjE1ZDg+
XSAgICBOb3QgdGFpbnRlZCBWTEkKRUZMQUdTOiAwMDAxMDA5NwpFSVAgaXMgYXQgMHhjMDQ2MTVk
OAplYXg6IGMwNDYxNWQ0ICAgZWJ4OiBjMDQ2MTVkMCAgIGVjeDogMDAwY2QxMWUgICBlZHg6IDAw
MDAwMDAzCmVzaTogYzlhOWU2ZDAgICBlZGk6IDAwMDAwMDAxICAgZWJwOiBkZmY4ZGY1MCAgIGVz
cDogZGZmOGRmMzQKZHM6IDAwN2IgICBlczogMDA3YiAgIHNzOiAwMDY4ClByb2Nlc3MgZXZlbnRz
LzAgKHBpZDogMywgdGhyZWFkaW5mbz1kZmY4YzAwMCB0YXNrPWMxNTFjY2UwKQpTdGFjazogYzAx
MWU3MDggYzA0NjE1ZDQgMDAwMDAwMDMgMDAwMDAwMDAgZGZmOGMwMDAgMDAwMDAyOTIgY2Y0Yjll
MGMgZGZmOGRmNzAKICAgICAgIGMwMTFlODUyIGM5YTllNmQ0IDAwMDAwMDAzIDAwMDAwMDAxIDAw
MDAwMDAwIGRmZmQyNDAwIGNmNGI5ZTEwIGRmZjhjMDAwCiAgICAgICBjMDEzMTA3MSBjZjRiOWU0
YyBkZmY4ZGZhMCAwMDAwMDAwMCBkZmZkMjQxOCBkZmZkMjQxMCBjZjRiOWU0YyBjMDEzMGI3NwpD
YWxsIFRyYWNlOgogW19fd2FrZV91cF9jb21tb24rNDkvODBdIF9fd2FrZV91cF9jb21tb24rMHgz
MS8weDUwCiBbPGMwMTFlNzA4Pl0gX193YWtlX3VwX2NvbW1vbisweDMxLzB4NTAKIFtjb21wbGV0
ZSs2NC8xMDFdIGNvbXBsZXRlKzB4NDAvMHg2NQogWzxjMDExZTg1Mj5dIGNvbXBsZXRlKzB4NDAv
MHg2NQogW3dvcmtlcl90aHJlYWQrNDcxLzcxMF0gd29ya2VyX3RocmVhZCsweDFkNy8weDJjNgog
WzxjMDEzMTA3MT5dIHdvcmtlcl90aHJlYWQrMHgxZDcvMHgyYzYKIFtfX2NhbGxfdXNlcm1vZGVo
ZWxwZXIrMC85N10gX19jYWxsX3VzZXJtb2RlaGVscGVyKzB4MC8weDYxCiBbPGMwMTMwYjc3Pl0g
X19jYWxsX3VzZXJtb2RlaGVscGVyKzB4MC8weDYxCiBbZGVmYXVsdF93YWtlX2Z1bmN0aW9uKzAv
NDRdIGRlZmF1bHRfd2FrZV9mdW5jdGlvbisweDAvMHgyYwogWzxjMDExZTZhYj5dIGRlZmF1bHRf
d2FrZV9mdW5jdGlvbisweDAvMHgyYwogW3JldF9mcm9tX2ZvcmsrNi8yMF0gcmV0X2Zyb21fZm9y
aysweDYvMHgxNAogWzxjMDM0YjZlZT5dIHJldF9mcm9tX2ZvcmsrMHg2LzB4MTQKIFtkZWZhdWx0
X3dha2VfZnVuY3Rpb24rMC80NF0gZGVmYXVsdF93YWtlX2Z1bmN0aW9uKzB4MC8weDJjCiBbPGMw
MTFlNmFiPl0gZGVmYXVsdF93YWtlX2Z1bmN0aW9uKzB4MC8weDJjCiBbd29ya2VyX3RocmVhZCsw
LzcxMF0gd29ya2VyX3RocmVhZCsweDAvMHgyYzYKIFs8YzAxMzBlOWE+XSB3b3JrZXJfdGhyZWFk
KzB4MC8weDJjNgogW2tlcm5lbF90aHJlYWRfaGVscGVyKzUvMTFdIGtlcm5lbF90aHJlYWRfaGVs
cGVyKzB4NS8weGIKIFs8YzAxMGIyMTE+XSBrZXJuZWxfdGhyZWFkX2hlbHBlcisweDUvMHhiClNl
cCAgNSAxMzoxOTowNSBib25nYW5pMSBrZXJuZWw6CkNvZGU6IDE1IDQ2IGMwIGIwIDE1IDQ2IGMw
IGIwIDE1IDQ2IGMwIGI4IDE1IDQ2IGMwIGI4IDE1IDQ2IGMwIGMwIDE1IDQ2IGMwIGMwCiAxNSA0
NiBjMCBjOCAxNSA0NiBjMCBjOCAxNSA0NiBjMCBkMCAxNSA0NiBjMCBkMCAxNSA0NiBjMCA8ZDg+
IDE1IDQ2IGMwIGQ4IDE1IDQ2IGMwIGQwIGU2IGE5IGM5IGQwIGU2IGE5IGM5IGU4CiAxNSA0NiBj
MCBlOAo=

--Multipart_Fri__5_Sep_2003_23:37:21_+0200_0833e8d8--

--og?rJmbR=.2+s=cv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/WQIZ+pvEqv8+FEMRAkDRAKCZQvrQCWphd0mV8hjhN7kD4ARtmQCeNbxR
1nIgCC5PD55jIrhrDL27m0I=
=/9hg
-----END PGP SIGNATURE-----

--og?rJmbR=.2+s=cv--
