Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbRFMVZD>; Wed, 13 Jun 2001 17:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFMVYx>; Wed, 13 Jun 2001 17:24:53 -0400
Received: from dialin-194-29-41-28.frankfurt.gigabell.net ([194.29.41.28]:36868
	"EHLO server1.localnet") by vger.kernel.org with ESMTP
	id <S262633AbRFMVYl>; Wed, 13 Jun 2001 17:24:41 -0400
Date: Wed, 13 Jun 2001 23:25:02 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-kernel@vger.kernel.org, ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
Message-Id: <20010613232502.34fd0237.rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.10.10106130952590.16375-100000@transvirtual.com>
In-Reply-To: <20010613172320.306d5208.rene.rebe@gmx.net>
	<Pine.LNX.4.10.10106130952590.16375-100000@transvirtual.com>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i686-pc-linux-gnu)
Organization: FreeSourceCommunity ;-)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__13_Jun_2001_23:25:02_+0200_081a5d70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__13_Jun_2001_23:25:02_+0200_081a5d70
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Thanks for the quick reply!

On Wed, 13 Jun 2001 09:54:21 -0700 (PDT)
James Simmons <jsimmons@transvirtual.com> wrote:

> 
> > I currently try to debug why the sisfb driver crashes my machine. (SIS 630
> > based laptop - linux-2.4.5-ac13).
> 
> You can do one of two things. Post both System.map and the complete oops
> or you can run ksymoops on the oops. I can find the problem then. Thanks.

ksymoops' output is attached.

[...]

k33p h4ck1n6 René

-- 
René Rebe (Registered Linux user: #127875)
http://www.rene.rebe.myokay.net/
-Germany-

Anyone sending unwanted advertising e-mail to this address will be charged
$25 for network traffic and computing time. By extracting my address from
this message or its header, you agree to these terms.

--Multipart_Wed__13_Jun_2001_23:25:02_+0200_081a5d70
Content-Type: application/octet-stream;
 name="ksymoops.txt"
Content-Disposition: attachment;
 filename="ksymoops.txt"
Content-Transfer-Encoding: base64

a3N5bW9vcHMgMi4zLjcgb24gaTY4NiAyLjQuNC1hYzUuICBPcHRpb25zIHVzZWQKICAgICAtViAo
c3BlY2lmaWVkKQogICAgIC1LIChzcGVjaWZpZWQpCiAgICAgLUwgKHNwZWNpZmllZCkKICAgICAt
TyAoc3BlY2lmaWVkKQogICAgIC1tIC9tbnQvbmV0L3BvcnRhYmxlL3Vzci9zcmMvbGludXgvU3lz
dGVtLm1hcCAoc3BlY2lmaWVkKQoKVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVl
c3QgYXQgdmlydHVhbCBhZGRyZXNzIGNjODAwMTgwCmMwMWI4ZjYxCipwZGUgPSAwYWYyZDA2NwpP
b3BzOiAwMDAyCkNQVTogICAgMApFSVA6ICAgIDAwMTA6WzxjMDFiOGY2MT5dClVzaW5nIGRlZmF1
bHRzIGZyb20ga3N5bW9vcHMgLXQgZWxmMzItaTM4NiAtYSBpMzg2CkVGTEFHUzogMDAwMTAyMDYK
ZWF4OiAwZjBmMGYwZiAgIGVieDogYzAyNmU1MWMgICBlY3g6IDAwMDAwMDAzICAgZWR4OiAwMDAw
MDAwMAplc2k6IGNjODAwMTgwICAgZWRpOiBjMDI2ZjQ2MCAgIGVicDogMGYwZjBmMGYgICBlc3A6
IGMxMmZkZTUwCmRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOApQcm9jZXNzIHN3YXBwZXIg
KHBpZDogMSwgc3RhY2twYWdlPWMxMmZkMDAwKQpTdGFjazogYzAyYzIzZTAgYzAyZGM0YzAgMDAw
MDA1OTMgMDAwMDAwMDAgY2M3ZmRjMDggZmZmZmZmZmYgMDAwMDAwMDAgMDAwMDAzMjAgCiAgICAg
ICBjYzdmZGMwMCBjMDFhYzc3YyBjMTJlZTAwMCBjMDJkYzRjMCBjMTJmZTM0MiAwMDAwMDAwMSAw
MDAwMDUxZSAwMDAwMDAwMCAKICAgICAgIGMxMmZlMzQwIGMxMmZlMzQyIDAwMDAwMDAxIDAwMDAw
NTkzIGMwMTgxNTBjIGMxMmVlMDAwIGMxMmZlMzQwIDAwMDAwMDAxIApDYWxsIFRyYWNlOiBbPGNj
N2ZkYzA4Pl0gWzxjYzdmZGMwMD5dIFs8YzAxYWM3N2M+XSBbPGMwMTgxNTBjPl0gWzxjMDE4MTU4
ND5dIAogICBbPGMwMWFkZWRlPl0gWzxjMDE4MWYwND5dIFs8YzAxODU2Zjk+XSBbPGMwMWFhZWI5
Pl0gWzxjMDEwNTAxMz5dIFs8YzAxMDU0MmM+XSAKQ29kZTogODkgMDYgOGEgMDMgMjQgMGYgMGYg
YjYgZDAgOGIgNDQgMjQgMTggMjMgMDQgOTcgMzEgZTggODkgNDYgCgo+PkVJUDsgYzAxYjhmNjEg
PGZiY29uX2NmYjhfcHV0Y3MrMWFkLzJjOD4gICA8PT09PT0KVHJhY2U7IGNjN2ZkYzA4IDxFTkRf
T0ZfQ09ERStjNTFhZDc4Lz8/Pz8+ClRyYWNlOyBjYzdmZGMwMCA8RU5EX09GX0NPREUrYzUxYWQ3
MC8/Pz8/PgpUcmFjZTsgYzAxYWM3N2MgPGZiY29uX3B1dGNzK2I4L2QwPgpUcmFjZTsgYzAxODE1
MGMgPGRvX3VwZGF0ZV9yZWdpb24rMTE4LzE2ND4KVHJhY2U7IGMwMTgxNTg0IDx1cGRhdGVfcmVn
aW9uKzJjLzM4PgpUcmFjZTsgYzAxYWRlZGUgPGZiY29uX3N3aXRjaCsxYWEvMWJjPgpUcmFjZTsg
YzAxODFmMDQgPHJlZHJhd19zY3JlZW4rZTAvMTYwPgpUcmFjZTsgYzAxODU2ZjkgPHRha2Vfb3Zl
cl9jb25zb2xlK2VkLzE4OD4KVHJhY2U7IGMwMWFhZWI5IDxyZWdpc3Rlcl9mcmFtZWJ1ZmZlcitm
OS8xNDA+ClRyYWNlOyBjMDEwNTAxMyA8aW5pdCs3LzExND4KVHJhY2U7IGMwMTA1NDJjIDxrZXJu
ZWxfdGhyZWFkKzI4LzM4PgpDb2RlOyAgYzAxYjhmNjEgPGZiY29uX2NmYjhfcHV0Y3MrMWFkLzJj
OD4KMDAwMDAwMDAgPF9FSVA+OgpDb2RlOyAgYzAxYjhmNjEgPGZiY29uX2NmYjhfcHV0Y3MrMWFk
LzJjOD4gICA8PT09PT0KICAgMDogICA4OSAwNiAgICAgICAgICAgICAgICAgICAgIG1vdiAgICAl
ZWF4LCglZXNpKSAgIDw9PT09PQpDb2RlOyAgYzAxYjhmNjMgPGZiY29uX2NmYjhfcHV0Y3MrMWFm
LzJjOD4KICAgMjogICA4YSAwMyAgICAgICAgICAgICAgICAgICAgIG1vdiAgICAoJWVieCksJWFs
CkNvZGU7ICBjMDFiOGY2NSA8ZmJjb25fY2ZiOF9wdXRjcysxYjEvMmM4PgogICA0OiAgIDI0IDBm
ICAgICAgICAgICAgICAgICAgICAgYW5kICAgICQweGYsJWFsCkNvZGU7ICBjMDFiOGY2NyA8ZmJj
b25fY2ZiOF9wdXRjcysxYjMvMmM4PgogICA2OiAgIDBmIGI2IGQwICAgICAgICAgICAgICAgICAg
bW92emJsICVhbCwlZWR4CkNvZGU7ICBjMDFiOGY2YSA8ZmJjb25fY2ZiOF9wdXRjcysxYjYvMmM4
PgogICA5OiAgIDhiIDQ0IDI0IDE4ICAgICAgICAgICAgICAgbW92ICAgIDB4MTgoJWVzcCwxKSwl
ZWF4CkNvZGU7ICBjMDFiOGY2ZSA8ZmJjb25fY2ZiOF9wdXRjcysxYmEvMmM4PgogICBkOiAgIDIz
IDA0IDk3ICAgICAgICAgICAgICAgICAgYW5kICAgICglZWRpLCVlZHgsNCksJWVheApDb2RlOyAg
YzAxYjhmNzEgPGZiY29uX2NmYjhfcHV0Y3MrMWJkLzJjOD4KICAxMDogICAzMSBlOCAgICAgICAg
ICAgICAgICAgICAgIHhvciAgICAlZWJwLCVlYXgKQ29kZTsgIGMwMWI4ZjczIDxmYmNvbl9jZmI4
X3B1dGNzKzFiZi8yYzg+CiAgMTI6ICAgODkgNDYgMDAgICAgICAgICAgICAgICAgICBtb3YgICAg
JWVheCwweDAoJWVzaSkKCiA8MD5LZXJuZWwgcGFuaWM6IEF0dGVtcHRlZCB0byBraWxsIGluaXQh
Cg==

--Multipart_Wed__13_Jun_2001_23:25:02_+0200_081a5d70--
