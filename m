Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRDQMJO>; Tue, 17 Apr 2001 08:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDQMJD>; Tue, 17 Apr 2001 08:09:03 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:37387 "EHLO
	mail.compro.net") by vger.kernel.org with ESMTP id <S129164AbRDQMIw>;
	Tue, 17 Apr 2001 08:08:52 -0400
Message-ID: <3ADC3262.C97B475@compro.net>
Date: Tue, 17 Apr 2001 08:09:06 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: amiga affs support broken in 2.4.x kernels??
In-Reply-To: <3AD59EB9.35F3A535@compro.net> <3AD9FEDD.2B636582@linux-m68k.org> <3ADAEA9B.D70DC130@compro.net> <3ADB1837.A0AE3020@linux-m68k.org>
Content-Type: multipart/mixed;
 boundary="------------8CCEF840B9D4AF04AB235146"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8CCEF840B9D4AF04AB235146
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Roman Zippel wrote:
> 
> Hi,
> 
> Mark Hounschell wrote:
> 
> > Thanks, I can now mount affs filesystems. However when I try to write
> > to it via "cp somefile /amiga/somefile" I get a segmentation fault. If
> > I then do a "df -h" it hangs the system very much like the mount command
> > did before I installed your tar-ball. Was write support expected from
> > it.
> 
> Yes, it should work.
> What sort of filesystem is it (ffs or ofs)? Did you check the dmesg
> output for an oops? Which kernel version did you use?
> 
> > Are you the NEW maintainer of the affs stuff.
> 
> Yes and as soon this problem is solved, I'm sending the changes to Linus
> and Alan.
> 
> bye, Roman

Hello Roman,
 Sorry I didn't get back to you yesterday afternoon. I was out of town.
 Attached is the output from dmesg and the relavent info from
/var/log/messages. I am using a vanilla 2.4.3 kernel with the
affs support compiled in. (No Modules). I beleive the filesystem is ffs
but not exactly sure. How do I tell?

Mark
--------------8CCEF840B9D4AF04AB235146
Content-Type: application/octet-stream;
 name="xx.dmesg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xx.dmesg"

VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZp
cnR1YWwgYWRkcmVzcyAwMDAwMDAzNAogcHJpbnRpbmcgZWlwOgpjMDFhYzFmMgoqcGRlID0g
MDAwMDAwMDAKT29wczogMDAwMApDUFU6ICAgIDAKRUlQOiAgICAwMDEwOls8YzAxYWMxZjI+
XQpFRkxBR1M6IDAwMDEwMjQ2CmVheDogYzEyZThlZTAgICBlYng6IDAwMDAwMDAwICAgZWN4
OiBjNmEwZWVjYyAgIGVkeDogMDAwMDBjMDkKZXNpOiBjNmEwZWUwMCAgIGVkaTogMDAwMDAw
MDAgICBlYnA6IDAwMDAwYzA5ICAgZXNwOiBjMzliMWUzYwpkczogMDAxOCAgIGVzOiAwMDE4
ICAgc3M6IDAwMTgKUHJvY2VzcyBjcCAocGlkOiA2NTksIHN0YWNrcGFnZT1jMzliMTAwMCkK
U3RhY2s6IDAwMDAwMDAxIDAwMDAwMDBhIGMyZjgzNGUwIGM2YTBlZTAwIGM2YTBlZWNjIGMx
MmU4ZWUwIGMwMWFiMDBkIGM2YTBlZTAwCiAgICAgICAwMDAwMGMwYiBjM2E4NmE2NCBjMzli
MWYwYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwYQogICAg
ICAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgYzAxMWYxYjAgYzNhODY5YzAgMDAwMDAw
NDggYzM5YjFmMGMgYzNhODY5YzAKQ2FsbCBUcmFjZTogWzxjMDFhYjAwZD5dIFs8YzAxMWYx
YjA+XSBbPGMwMTNmY2ZlPl0gWzxjMDFhOTE1Nz5dIFs8YzAxM2ZlNDE+XSBbPGMwMTJiYzA5
Pl0gWzxjMDEzN2MyND5dCiAgICAgICBbPGMwMTJjYTE3Pl0gWzxjMDEyY2QyYz5dIFs8YzAx
MDZlMmY+XQogCkNvZGU6IDhiIDQzIDM0IDg5IGU5IGMxIGVkIDA1IDhkIDE0IGE4IDhiIDQy
IDA0IDBmIGM4IDgzIGUxIDFmIGJmCg==
--------------8CCEF840B9D4AF04AB235146
Content-Type: application/octet-stream;
 name="xx.messages"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xx.messages"

QXByIDE3IDA3OjQ5OjMwIGhhcmxleSBrZXJuZWw6IFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MKMDAwMDAwMzQK
QXByIDE3IDA3OjQ5OjMwIGhhcmxleSBrZXJuZWw6ICBwcmludGluZyBlaXA6CkFwciAxNyAw
Nzo0OTozMCBoYXJsZXkga2VybmVsOiBjMDFhYzFmMgpBcHIgMTcgMDc6NDk6MzAgaGFybGV5
IGtlcm5lbDogKnBkZSA9IDAwMDAwMDAwCkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVs
OiBPb3BzOiAwMDAwCkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBDUFU6ICAgIDAK
QXByIDE3IDA3OjQ5OjMwIGhhcmxleSBrZXJuZWw6IEVJUDogICAgMDAxMDpbYWZmc19mcmVl
X2Jsb2NrKzE3NC8zNjRdCkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBFRkxBR1M6
IDAwMDEwMjQ2CkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBlYXg6IGMxMmU4ZWUw
ICAgZWJ4OiAwMDAwMDAwMCAgIGVjeDogYzZhMGVlY2MgICBlZHg6IDAwMDAwYzA5CkFwciAx
NyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBlc2k6IGM2YTBlZTAwICAgZWRpOiAwMDAwMDAw
MCAgIGVicDogMDAwMDBjMDkgICBlc3A6IGMzOWIxZTNjCkFwciAxNyAwNzo0OTozMCBoYXJs
ZXkga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgKQXByIDE3IDA3OjQ5
OjMwIGhhcmxleSBrZXJuZWw6IFByb2Nlc3MgY3AgKHBpZDogNjU5LCBzdGFja3BhZ2U9YzM5
YjEwMDApCkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBTdGFjazogMDAwMDAwMDEg
MDAwMDAwMGEgYzJmODM0ZTAgYzZhMGVlMDAgYzZhMGVlY2MgYzEyZThlZTAgYzAxYWIwMGQg
YzZhMGVlMDAKQXByIDE3IDA3OjQ5OjMwIGhhcmxleSBrZXJuZWw6ICAgICAgICAwMDAwMGMw
YiBjM2E4NmE2NCBjMzliMWYwYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwYQpBcHIgMTcgMDc6NDk6MzAgaGFybGV5IGtlcm5lbDogICAgICAgIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIGMwMTFmMWIwIGMzYTg2OWMwIDAwMDAwMDQ4IGMzOWIx
ZjBjIGMzYTg2OWMwCkFwciAxNyAwNzo0OTozMCBoYXJsZXkga2VybmVsOiBDYWxsIFRyYWNl
OiBbYWZmc190cnVuY2F0ZSs2MDEvOTU2XSBbdm10cnVuY2F0ZSszMTYvMzI4XSBbaW5vZGVf
c2V0YXR0cis1NC8xNjRdIFthZmZzX25vdGlmeV9jaGFuZ2UrMTI3LzE1Ml0gW25vdGlmeV9j
aGFuZ2UrOTcvMTkyXSBbZG9fdHJ1bmNhdGUrNzMvOTZdIFtvcGVuX25hbWVpKzExMDgvMTQ0
MF0KQXByIDE3IDA3OjQ5OjMwIGhhcmxleSBrZXJuZWw6ICAgICAgICBbZmlscF9vcGVuKzU5
LzkyXSBbc3lzX29wZW4rNTYvMTgwXSBbc3lzdGVtX2NhbGwrNTEvNTZdCkFwciAxNyAwNzo0
OTozMCBoYXJsZXkga2VybmVsOgpBcHIgMTcgMDc6NDk6MzAgaGFybGV5IGtlcm5lbDogQ29k
ZTogOGIgNDMgMzQgODkgZTkgYzEgZWQgMDUgOGQgMTQgYTggOGIgNDIgMDQgMGYgYzggODMg
ZTEgMWYgYmYK
--------------8CCEF840B9D4AF04AB235146--

