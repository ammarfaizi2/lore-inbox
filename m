Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTASHkw>; Sun, 19 Jan 2003 02:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTASHkw>; Sun, 19 Jan 2003 02:40:52 -0500
Received: from imap.gmx.net ([213.165.65.60]:4182 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265532AbTASHkv>;
	Sun, 19 Jan 2003 02:40:51 -0500
Message-Id: <5.1.1.6.2.20030119084031.00c81180@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sun, 19 Jan 2003 08:46:35 +0100
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
From: Mike Galbraith <efault@gmx.de>
Subject: 2.5.59mm2 BUG at fs/jbd/transaction.c:1148
In-Reply-To: <20030118002027.2be733c7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_11828437==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_11828437==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Greetings,

I got the attached oops upon doing my standard reboot sequence SysRq[sub].

fwiw, I was fiddling with an ext2 ramdisk just prior to poking buttons.

	-Mike
--=====================_11828437==_
Content-Type: application/octet-stream; name="oops"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oops"

U3lzUnEgOiBFbWVyZ2VuY3kgU3luYwpTeW5jaW5nIGRldmljZSBpZGUwKDMsNikgLi4uIE9LClN5
bmNpbmcgZGV2aWNlIGlkZTAoMyw3KSAuLi4gCjwwPkFzc2VydGlvbiBmYWlsdXJlIGluIGpvdXJu
YWxfZGlydHlfbWV0YWRhdGEoKSBhdCBmcy9qYmQvdHJhbnNhY3Rpb24uYzoxMTQ4OiAiamgtPmJf
amxpc3QgIT0gMSIKLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tCmtlcm5lbCBC
VUcgYXQgZnMvamJkL3RyYW5zYWN0aW9uLmM6MTE0OCEKaW52YWxpZCBvcGVyYW5kOiAwMDAwCkNQ
VTogICAgMApFSVA6ICAgIDAwNjA6WzxjMDE3NTVlND5dICAgIE5vdCB0YWludGVkCkVGTEFHUzog
MDAwMTAyODYKRUlQIGlzIGF0IGpvdXJuYWxfZGlydHlfbWV0YWRhdGErMHgxMGMvMHgxNzQKZWF4
OiAwMDAwMDA2MiAgIGVieDogYzMzYWViODAgICBlY3g6IGMzMWRmOGUwICAgZWR4OiBjMDI3ZmJi
MAplc2k6IGMzMmI5MjYwICAgZWRpOiBjN2E4OWUwMCAgIGVicDogYzdhODM5YzAgICBlc3A6IGMz
MWUxY2NjCmRzOiAwMDdiICAgZXM6IDAwN2IgICBzczogMDA2OApQcm9jZXNzIHN5c2xvZ2QgKHBp
ZDogMTAyLCB0aHJlYWRpbmZvPWMzMWUwMDAwIHRhc2s9YzMxZGY4ZTApClN0YWNrOiBjMDI0OWNh
MCBjMDI0YTFjMSBjMDI0OWM4MCAwMDAwMDQ3YyBjMDI0YTFkOCBjMzE3Y2QzYyBjN2E4MzljMCAw
MDAwMDAwMCAKICAgICAgIGMzMWUxZDY0IGMwMTY5YmQxIGM3YTgzOWMwIGMzMTdjZDNjIGMzMTdj
ZDNjIDAwMDAxMDAwIGMzMTdjZDNjIDAwMDAxMDAwIAogICAgICAgMDAwMDAwNTAgMDAwMDAwNDAg
YzAxNjk5OTQgYzdhODM5YzAgYzMxN2NkM2MgMDAwMTAwMDAgMDAwMDAwMDAgYzMxYzU2NjAgCkNh
bGwgVHJhY2U6CiBbPGMwMTY5YmQxPl0gY29tbWl0X3dyaXRlX2ZuKzB4MTkvMHg2MAogWzxjMDE2
OTk5ND5dIHdhbGtfcGFnZV9idWZmZXJzKzB4NTAvMHg3NAogWzxjMDE2OWNkYT5dIGV4dDNfY29t
bWl0X3dyaXRlKzB4YzIvMHgxZDgKIFs8YzAxNjliYjg+XSBjb21taXRfd3JpdGVfZm4rMHgwLzB4
NjAKIFs8YzAxMjllMTM+XSBnZW5lcmljX2ZpbGVfYWlvX3dyaXRlX25vbG9jaysweDc5Ny8weDk4
NAogWzxjMDFmMmJhYj5dIGtmcmVlX3NrYm1lbSsweGIvMHg1NAogWzxjMDFmMmNiNj5dIF9fa2Zy
ZWVfc2tiKzB4YzIvMHhjOAogWzxjMDIzMGZiYT5dIHVuaXhfc3RyZWFtX3JlY3Ztc2crMHgyZWEv
MHgzNzAKIFs8YzAxMmEwNmY+XSBnZW5lcmljX2ZpbGVfd3JpdGVfbm9sb2NrKzB4NmYvMHg4Ywog
WzxjMDFlZmU0Nj5dIHNvY2tfYWlvX3JlYWQrMHg4YS8weDljCiBbPGMwMTNjYWIxPl0gZG9fc3lu
Y19yZWFkKzB4ODEvMHhiMAogWzxjMDExNjNiZD5dIGRvX3NjaGVkdWxlKzB4MjM1LzB4MjVjCiBb
PGMwMTJhMjI1Pl0gZ2VuZXJpY19maWxlX3dyaXRldisweDMxLzB4NDQKIFs8YzAxM2QwOGI+XSBk
b19yZWFkdl93cml0ZXYrMHgxYTcvMHgyN2MKIFs8YzAxM2NiZTA+XSBkb19zeW5jX3dyaXRlKzB4
MC8weGIwCiBbPGMwMTcyMDVkPl0gZXh0M19mb3JjZV9jb21taXQrMHgxZC8weDI0CiBbPGMwMTY3
NWJiPl0gZXh0M19zeW5jX2ZpbGUrMHg1Yi8weDcwCiBbPGMwMTNkMWY3Pl0gdmZzX3dyaXRldisw
eDRiLzB4NTAKIFs8YzAxM2QyNjI+XSBzeXNfd3JpdGV2KzB4MmEvMHgzYwogWzxjMDEwYTM2Nz5d
IHN5c2NhbGxfY2FsbCsweDcvMHhiCg==
--=====================_11828437==_--

