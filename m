Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136096AbRAMBel>; Fri, 12 Jan 2001 20:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136203AbRAMBeX>; Fri, 12 Jan 2001 20:34:23 -0500
Received: from sc-66-27-47-84.socal.rr.com ([66.27.47.84]:38919 "EHLO
	falcon.bellfamily.org") by vger.kernel.org with ESMTP
	id <S136155AbRAMBeC>; Fri, 12 Jan 2001 20:34:02 -0500
Message-ID: <3A5FB0A8.4040506@bellfamily.org>
Date: Fri, 12 Jan 2001 17:34:32 -0800
From: "Robert J. Bell" <rob@bellfamily.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
In-Reply-To: <3A5F8956.9040305@bellfamily.org> <20010112151008.A5798@one-eyed-alien.net> <3A5F9108.4030706@bellfamily.org> <20010112152415.B5798@one-eyed-alien.net> <3A5F9491.20109@bellfamily.org> <20010112161347.A6792@one-eyed-alien.net>
Content-Type: multipart/mixed;
 boundary="------------070107020702050007000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107020702050007000800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No luck using the standard UHCI driver, attached logs.

Matthew Dharm wrote:

> Do you have an OHCI controller or an UHCI controller?  I noticed that
> you're using the "alternate" UHCI driver... can you try this with the
> standard UHCI driver?
> 
> Matt
> 
> On Fri, Jan 12, 2001 at 03:34:41PM -0800, Robert J. Bell wrote:
> 
>> Unfortunately I lost everything on my system (the one that worked) and I 
>> don't believe I ever looked in /proc/scsi/scsi because It was working 
>> and I didn't feel the need to go poking around.  I had this problem 
>> initially the first time I compiled 2.4.0 but I went back and added SCSI 
>> Generic "on" and that seemed to fix it.  I am just confused why it 
>> thinks this is a scanner. IS there any way to force it to detect it as a 
>> scsi disk?
>> 
>> I must have recompiled this kernel 50 times trying to recreate the the 
>> scenario where this worked. I can send you my .config if you think that 
>> will help.
>> 
>> Robert
>> 
>> 
>> 
>> 
>> 
>> Matthew Dharm wrote:
>> 
>>> Hrm... from these logs, everything looks okay, except for the fact that the
>>> device refuses to return any INQUIRY data.
>>> 
>>> Can you reproduce the conditions under which it was working and send logs
>>> from that?  Or at least remember what the /proc/scsi/scsi info looked like?
>>> 
>>> Matt
>>> 
>>> On Fri, Jan 12, 2001 at 03:19:36PM -0800, Robert J. Bell wrote:
>>> 
>>>> Matthew here is the info you requested, thanks for your help.
>>>> 
>>>> 


--------------070107020702050007000800
Content-Type: application/octet-stream;
 name="dmesg2.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg2.out"

Cmh1Yi5jOiBwb3J0IDEgY29ubmVjdGlvbiBjaGFuZ2UKaHViLmM6IHBvcnQgMSwgcG9ydHN0
YXR1cyAxMDAsIGNoYW5nZSAzLCAxMiBNYi9zCnVzYi5jOiBVU0IgZGlzY29ubmVjdCBvbiBk
ZXZpY2UgMgp1c2ItdWhjaS5jOiBpbnRlcnJ1cHQsIHN0YXR1cyAzLCBmcmFtZSMgMTA2MAp1
c2IuYzoga3VzYmQ6IC9zYmluL2hvdHBsdWcgcmVtb3ZlIDIKdXNiLmM6IGt1c2JkIHBvbGlj
eSByZXR1cm5lZCAweGZmZmZmZmZlCmh1Yi5jOiBwb3J0IDEgZW5hYmxlIGNoYW5nZSwgc3Rh
dHVzIDEwMApodWIuYzogcG9ydCAxIGNvbm5lY3Rpb24gY2hhbmdlCmh1Yi5jOiBwb3J0IDEs
IHBvcnRzdGF0dXMgMTAxLCBjaGFuZ2UgMSwgMTIgTWIvcwpodWIuYzogcG9ydCAxLCBwb3J0
c3RhdHVzIDEwMywgY2hhbmdlIDAsIDEyIE1iL3MKaHViLmM6IFVTQiBuZXcgZGV2aWNlIGNv
bm5lY3Qgb24gYnVzMS8xLCBhc3NpZ25lZCBkZXZpY2UgbnVtYmVyIDMKdXNiLmM6IGttYWxs
b2MgSUYgY2MxOTNmZTAsIG51bWlmIDEKdXNiLmM6IG5ldyBkZXZpY2Ugc3RyaW5nczogTWZy
PTAsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTMKdXNiLmM6IFVTQiBkZXZpY2UgbnVtYmVy
IDMgZGVmYXVsdCBsYW5ndWFnZSBJRCAweDQwOQpQcm9kdWN0OiBVU0IgTWFzcyBTdG9yYWdl
ClNlcmlhbE51bWJlcjogWS0xNzBeXl5eXjAwMDgxMFgwMDAwMDAzMDA1MjM3CnVzYi1zdG9y
YWdlOiBTZWFyY2hpbmcgdW51c3VhbCBkZXZpY2UgbGlzdCBmb3IgKDB4NGNiLCAweDEwMCwg
MHgxMDAwKS4uLgp1c2Itc3RvcmFnZTogLS0gZGlkIG5vdCBmaW5kIGEgbWF0Y2hpbmcgZGV2
aWNlCnVzYi1zdG9yYWdlOiBVU0IgTWFzcyBTdG9yYWdlIGRldmljZSBkZXRlY3RlZAp1c2It
c3RvcmFnZTogRW5kcG9pbnRzOiBJbjogMHhjMTQ0ZGVlMCBPdXQ6IDB4YzE0NGRlZjQgSW50
OiAweGMxNDRkZjA4IChQZXJpb2QgMSkKdXNiLXN0b3JhZ2U6IE5ldyBHVUlEIDA0Y2IwMTAw
MTIxMDAwMDAwMzAwNTIzNwp1c2Itc3RvcmFnZTogVHJhbnNwb3J0OiBDb250cm9sL0J1bGsv
SW50ZXJydXB0CnVzYi1zdG9yYWdlOiBQcm90b2NvbDogODA3MGkKdXNiLXN0b3JhZ2U6IEFs
bG9jYXRpbmcgSVJRIGZvciBDQkkgdHJhbnNwb3J0CnVzYi1zdG9yYWdlOiB1c2Jfc3VibWl0
X3VyYigpIHJldHVybnMgMAp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBzbGVlcGluZy4Kc2Nz
aTAgOiBTQ1NJIGVtdWxhdGlvbiBmb3IgVVNCIE1hc3MgU3RvcmFnZSBkZXZpY2VzCnVzYi1z
dG9yYWdlOiBxdWV1ZWNvbW1hbmQoKSBjYWxsZWQKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQg
YXdha2VuZWQuCnVzYi1zdG9yYWdlOiBDb21tYW5kIElOUVVJUlkgKDYgYnl0ZXMpCnVzYi1z
dG9yYWdlOiAxMiAwMCAwMCAwMCBmZiAwMCAwMCAwMCAxOCA4MyA0NSBjMQp1c2Itc3RvcmFn
ZTogQ2FsbCB0byB1c2Jfc3Rvcl9jb250cm9sX21zZygpIHJldHVybmVkIDEyCnVzYi1zdG9y
YWdlOiB1c2Jfc3Rvcl90cmFuc2Zlcl9wYXJ0aWFsKCk6IHhmZXIgMjU1IGJ5dGVzCnVzYi1z
dG9yYWdlOiBVU0IgSVJRIHJlY2lldmVkIGZvciBkZXZpY2Ugb24gaG9zdCAwCnVzYi1zdG9y
YWdlOiAtLSBJUlEgZGF0YSBsZW5ndGggaXMgMgp1c2Itc3RvcmFnZTogLS0gSVJRIHN0YXRl
IGlzIDAKdXNiLXN0b3JhZ2U6IC0tIEludGVycnVwdCBTdGF0dXMgKDB4MCwgMHgwKQp1c2It
c3RvcmFnZTogLS0gQ3VycmVudCB2YWx1ZSBvZiBpcF93YWl0cSBpczogMAp1c2Itc3RvcmFn
ZTogdXNiX3N0b3JfYnVsa19tc2coKSByZXR1cm5lZCAwIHhmZXJyZWQgMC8yNTUKdXNiLXN0
b3JhZ2U6IENCSSBkYXRhIHN0YWdlIHJlc3VsdCBpcyAweDEKdXNiLXN0b3JhZ2U6IEN1cnJl
bnQgdmFsdWUgb2YgaXBfd2FpdHEgaXM6IDEKdXNiLXN0b3JhZ2U6IEdvdCBpbnRlcnJ1cHQg
ZGF0YSAoMHgwLCAweDApCnVzYi1zdG9yYWdlOiBGaXhpbmcgSU5RVUlSWSBkYXRhIHRvIHNo
b3cgU0NTSSByZXYgMgp1c2Itc3RvcmFnZTogc2NzaSBjbWQgZG9uZSwgcmVzdWx0PTB4MAp1
c2Itc3RvcmFnZTogKioqIHRocmVhZCBzbGVlcGluZy4KICBWZW5kb3I6ICDgLcAgwPLPICBN
b2RlbDoghiAgINj/LcChIyDAIN3yzyAgUmV2OiD/////CiAgVHlwZTogICBTY2FubmVyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEFOU0kgU0NTSSByZXZpc2lvbjogMDIKdXNiLXN0
b3JhZ2U6IHF1ZXVlY29tbWFuZCgpIGNhbGxlZAp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBh
d2FrZW5lZC4KdXNiLXN0b3JhZ2U6IEJhZCB0YXJnZXQgbnVtYmVyICgxLzApCnVzYi1zdG9y
YWdlOiAqKiogdGhyZWFkIHNsZWVwaW5nLgp1c2Itc3RvcmFnZTogcXVldWVjb21tYW5kKCkg
Y2FsbGVkCnVzYi1zdG9yYWdlOiAqKiogdGhyZWFkIGF3YWtlbmVkLgp1c2Itc3RvcmFnZTog
QmFkIHRhcmdldCBudW1iZXIgKDIvMCkKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQgc2xlZXBp
bmcuCnVzYi1zdG9yYWdlOiBxdWV1ZWNvbW1hbmQoKSBjYWxsZWQKdXNiLXN0b3JhZ2U6ICoq
KiB0aHJlYWQgYXdha2VuZWQuCnVzYi1zdG9yYWdlOiBCYWQgdGFyZ2V0IG51bWJlciAoMy8w
KQp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBzbGVlcGluZy4KdXNiLXN0b3JhZ2U6IHF1ZXVl
Y29tbWFuZCgpIGNhbGxlZAp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBhd2FrZW5lZC4KdXNi
LXN0b3JhZ2U6IEJhZCB0YXJnZXQgbnVtYmVyICg0LzApCnVzYi1zdG9yYWdlOiAqKiogdGhy
ZWFkIHNsZWVwaW5nLgp1c2Itc3RvcmFnZTogcXVldWVjb21tYW5kKCkgY2FsbGVkCnVzYi1z
dG9yYWdlOiAqKiogdGhyZWFkIGF3YWtlbmVkLgp1c2Itc3RvcmFnZTogQmFkIHRhcmdldCBu
dW1iZXIgKDUvMCkKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQgc2xlZXBpbmcuCnVzYi1zdG9y
YWdlOiBxdWV1ZWNvbW1hbmQoKSBjYWxsZWQKdXNiLXN0b3JhZ2U6ICoqKiB0aHJlYWQgYXdh
a2VuZWQuCnVzYi1zdG9yYWdlOiBCYWQgdGFyZ2V0IG51bWJlciAoNi8wKQp1c2Itc3RvcmFn
ZTogKioqIHRocmVhZCBzbGVlcGluZy4KdXNiLXN0b3JhZ2U6IHF1ZXVlY29tbWFuZCgpIGNh
bGxlZAp1c2Itc3RvcmFnZTogKioqIHRocmVhZCBhd2FrZW5lZC4KdXNiLXN0b3JhZ2U6IEJh
ZCB0YXJnZXQgbnVtYmVyICg3LzApCnVzYi1zdG9yYWdlOiAqKiogdGhyZWFkIHNsZWVwaW5n
LgpXQVJOSU5HOiBVU0IgTWFzcyBTdG9yYWdlIGRhdGEgaW50ZWdyaXR5IG5vdCBhc3N1cmVk
ClVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlIGZvdW5kIGF0IDMKdXNiLmM6IHVzYi1zdG9yYWdl
IGRyaXZlciBjbGFpbWVkIGludGVyZmFjZSBjYzE5M2ZlMAp1c2IuYzoga3VzYmQ6IC9zYmlu
L2hvdHBsdWcgYWRkIDMKdXNiLmM6IGt1c2JkIHBvbGljeSByZXR1cm5lZCAweGZmZmZmZmZl
Cg==
--------------070107020702050007000800
Content-Type: application/octet-stream;
 name="mesg.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mesg.out"

SmFuIDEyIDE3OjI1OjE3IHQyMCBQQU1fdW5peFs2NDhdOiAobG9naW4pIHNlc3Npb24gb3Bl
bmVkIGZvciB1c2VyIHJvb3QgYnkgTE9HSU4odWlkPTApCkphbiAxMiAxNzoyNToxNyB0MjAg
IC0tIHJvb3RbNjQ4XTogUk9PVCBMT0dJTiBPTiB0dHkxCkphbiAxMiAxNzoyNjoxMyB0MjAg
a2VybmVsOiB1c2IuYzogVVNCIGRpc2Nvbm5lY3Qgb24gZGV2aWNlIDIKSmFuIDEyIDE3OjI2
OjEzIHQyMCBrZXJuZWw6IHVzYi11aGNpLmM6IGludGVycnVwdCwgc3RhdHVzIDMsIGZyYW1l
IyAxMDYwCkphbiAxMiAxNzoyNjo1NSB0MjAga2VybmVsOiBodWIuYzogVVNCIG5ldyBkZXZp
Y2UgY29ubmVjdCBvbiBidXMxLzEsIGFzc2lnbmVkIGRldmljZSBudW1iZXIgMwpKYW4gMTIg
MTc6MjY6NTUgdDIwIGtlcm5lbDogUHJvZHVjdDogVVNCIE1hc3MgU3RvcmFnZQpKYW4gMTIg
MTc6MjY6NTUgdDIwIGtlcm5lbDogU2VyaWFsTnVtYmVyOiBZLTE3MF5eXl5eMDAwODEwWDAw
MDAwMDMwMDUyMzcKSmFuIDEyIDE3OjI2OjU1IHQyMCBrZXJuZWw6IHNjc2kwIDogU0NTSSBl
bXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlcwpKYW4gMTIgMTc6MjY6NTUg
dDIwIGtlcm5lbDogICBWZW5kb3I6ICDgLcAgwPLPICBNb2RlbDogXDIwNiAgINj/LcChIyDA
IN3yzyAgUmV2OiD/////CkphbiAxMiAxNzoyNjo1NSB0MjAga2VybmVsOiAgIFR5cGU6ICAg
U2Nhbm5lciAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTlNJIFNDU0kgcmV2aXNpb246
IDAyCg==
--------------070107020702050007000800--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
