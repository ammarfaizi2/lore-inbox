Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWHANXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWHANXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWHANXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:23:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:33640 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932524AbWHANXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=sMQWiU2EmAO+WhG+2eQswBlrHJqTrjyRBaNBsOf95oDf0BkQzal/PHho1WYVA00QXI4fswXfOLos9smArKPx93k1cf8+yoVKtUSZ20f+S+v76mz6YYI4qBhylGzNe4c3dVTHsr/UOO2wueeL5uhgYlWZNhqs5/HPLpcaCeNc9xo=
Message-ID: <e084545e0608010623l1b6f07em4dda91c18121ecd2@mail.gmail.com>
Date: Tue, 1 Aug 2006 15:23:37 +0200
From: "=?ISO-8859-1?Q?Omar_A=EFt_Mous?=" <omar.aitmous@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Connection tracking synchronization module
In-Reply-To: <e084545e0608010617h9941cbchd366cf3ee6bcb0d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_41951_19840097.1154438617206"
References: <e084545e0608010617h9941cbchd366cf3ee6bcb0d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_41951_19840097.1154438617206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 8/1/06, Omar A=EFt Mous <omar.aitmous@gmail.com> wrote:
> This is a kernel module to allow real-time synchronization of connection
> tracking tables between two linux routers. It will be useful for people w=
illing
> to achieve high availability of stateful firewalls, or NAT routers. It's =
our
> first attempt at kernel hacking, so there is probably many errors and thi=
ngs to
> fix, but it Works For Us (TM). you can even test it without recompiling y=
our
> kernel. see attached README file for the gory details. You would be so ki=
nd to
> cc: us when replying ! :)
> Latest version can be found here :
> http://enix.fr/projects/syntrack/browser/tarballs/revision-90.tar.gz?form=
at=3Draw
> Or here for future releases :
> http://enix.fr/projects/syntrack/browser/tarballs
>
And here is the attached README.

------=_Part_41951_19840097.1154438617206
Content-Type: application/octet-stream; name=README
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqcax8lh
Content-Disposition: attachment; filename="README"

U3ludHJhY2sgbW9kdWxlCj09PT09PT09PT09PT09PQoKVGhpcyBrZXJuZWwgbW9kdWxlIGNhbiBi
ZSB1c2VkIHRvIGtlZXAgdGhlIGNvbm5lY3Rpb24gdHJhY2tpbmcgdGFibGVzIG9mIHR3bwpMaW51
eCByb3V0ZXJzIGluIHN5bmMuIFRoZSBtb2R1bGUgaXRzZWxmIHdpbGwgYWxsb3cgcmVhZGluZyAm
IHdyaXRpbmcgdGhlCmNvbm50cmFjayB0YWJsZSB0aHJ1IGEgY2hhcmFjdGVyIGRldmljZSAoL2Rl
di9zeW50cmFjayA7IHNob3VsZCBiZSBjcmVhdGVkCmF1dG9tYXRpY2FsbHkgd2l0aCB5b3VyIGF2
ZXJhZ2UgdWRldiBjb25maWd1cmF0aW9uKS4gVG8gc3luY2hyb25pemUgdGhlIHRhYmxlCndpdGgg
YW5vdGhlciByb3V0ZXIvZmlyZXdhbGwsIHlvdSB3aWxsIGFsc28gbmVlZCBhIHVzZXJsYW5kIHRv
b2wuCgpUbyBjb21waWxlIDoKSWYgdGhlIGtlcm5lbCBoYXMgYmVlbiBwYXRjaGVkIGFjY29yZGlu
ZyB0byB0aGUgY2hhbmdlcyBkZXNjcmliZWQgYmVsb3csCm1ha2UgRVhUUkFfQ0ZMQUdTPS1ETkFU
X0VYUE9SVEVECm90aGVyd2lzZSwKbWFrZQoKVG8gZXhlY3V0ZSA6Ck9uY2UgY29tcGlsZWQsIHlv
dSdsbCBmaW5kIGluIHRoZSBzb3VyY2UgZGlyZWN0b3J5IGEgZmlsZSBuYW1lZCAnc3ludHJhY2su
a28nIApjb3JyZXNwb25kaW5nIHRvIHRoZSBtb2R1bGUgOyBpbnNtb2QgaXQgaW50byB5b3VyIHJ1
bm5pbmcga2VybmVsLiBJdCBzaG91bGQKY3JlYXRlIHRoZSAvZGV2L3N5bnRyYWNrIGRldmljZS4K
VG8gdGVzdCB0aGUgd2hvbGUgc3luY2hyb25pemF0aW9uIHByb2Nlc3MsIHlvdSB3aWxsIG5lZWQg
dHdvIExpbnV4IHJvdXRlcnMsCndoaWNoIHNob3VsZCBydW4gdGhlIHNhbWUga2VybmVsIChubyB0
ZXN0aW5nIGhhcyBiZWVuIGRvbmUgeWV0IHdpdGggZGlmZmVyZW50Cmtlcm5lbCB2ZXJzaW9ucyA7
IGl0IHNob3VsZCB3b3JrIGFzIGxvbmcgYXMgdGhlIHNhbWUgY29ubnRyYWNrIG9wdGlvbnMgaGF2
ZQpiZWVuIHNldCBvbiBib3RoIHNpZGVzKS4KUnVuICJzeW50cmFja19zZW5kIGJhY2t1cC5pcCIg
b24gdGhlICJtYWluIiByb3V0ZXIsIGFuZCAic3ludHJhY2tfcmVjdiBtYWluLmlwIgpvbiB0aGUg
ImJhY2t1cCIgcm91dGVyLiBGcm9tIG5vdyBvbiwgdGhlIC9wcm9jL25ldC9pcF9jb25udHJhY2sg
c3BlY2lhbCBmaWxlCm9uIHRoZSBiYWNrdXAgcm91dGVyIHdpbGwgcmVmbGVjdCB0aGUgY2hhbmdl
cyBvZiB0aGUgc2FtZSBmaWxlIG9uIHRoZSBtYWluCnJvdXRlci4KCklmIHlvdSB3YW50IE5BVCB0
byB3b3JrIGNvcnJlY3RseSwgeW91IHNob3VsZCBhcHBseSB0aGUgZm9sbG93aW5nIGNoYW5nZXMg
dG8KeW91ciBrZXJuZWwgc291cmNlcyA6CgkKRmlsZSA6IGlwX25hdF9jb3JlLmMgKG5ldC9pcHY0
L25ldGZpbHRlcikKbGluZSA0NyA6IC8qc3RhdGljICovdW5zaWduZWQgaW50IGlwX25hdF9odGFi
bGVfc2l6ZTsKbGluZSA0OSA6IC8qc3RhdGljICovc3RydWN0IGxpc3RfaGVhZCAqYnlzb3VyY2U7
CgpuZXcgZXhwb3J0ZWQgc3ltYm9scyA6CkVYUE9SVF9TWU1CT0xfR1BMKGlwX25hdF9odGFibGVf
c2l6ZSk7CkVYUE9SVF9TWU1CT0xfR1BMKGlwX25hdF9sb2NrKTsKRVhQT1JUX1NZTUJPTF9HUEwo
Ynlzb3VyY2UpOwoKWW91IGNhbiBhbHNvIGRvIHRoaXMgdXNpbmcgdGhlIHBhdGNoIGZpbGUgbmF0
LmRpZmYgOgoJcGF0Y2ggLXAxIDwgbmF0LmRpZmYKYXQgdGhlIGxpbnV4IGtlcm5lbCBzb3VyY2Ug
ZGlyZWN0b3J5LgpUbyB1bnBhdGNoLCBqdXN0IHRyeSA6CglwYXRjaCAtcDEgLVIgPCBuYXQuZGlm
ZgphdCB0aGUgc2FtZSBkaXJlY3RvcnkuCldpdGhvdXQgdGhvc2UgY2hhbmdlcywgc3luY2hyb25p
emF0aW9uIHdpdGhvdXQgTkFUIHdpbGwgd29yayA7IHVzYWdlIG9mIE5BVAp3aWxsIHlpZWxkIHVu
cHJlZGljdGFibGUgcmVzdWx0cyBob3dldmVyLgoK
------=_Part_41951_19840097.1154438617206--
