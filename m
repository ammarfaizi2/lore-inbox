Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUHMH7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUHMH7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUHMH7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:59:53 -0400
Received: from pop.gmx.net ([213.165.64.20]:63461 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269022AbUHMH7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:59:47 -0400
Date: Fri, 13 Aug 2004 09:59:46 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary212881092383986"
Subject: linux-2.6.8-rc4-bk1 - nfsd oops when starting the first client
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <21288.1092383986@www20.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary212881092383986
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

i am getting reproducible kernel oopses in a test environment
when booting the first diskless client (2.0.40-rc6)
for a dual (=SMP) AMD Athlon(tm) MP 1900+ that 
is running a recent linux 2.6 bitkeeper kernel.
the oops exactly happens when the (trough bootp provided)
kernel on the client has fully started and wants 
to access one of the first files on the server
by means of an nfs access.

see the system messages in the attachment.

the problem was never seen in kernel 2.6.7 
for that or any other server.

is this problem known to the audience?
is there a patch to test for this problem?

-Alex. (i am not subscribed to this list, please CC me)

PS: due to sheduled two weeks absence i will not be able
to check my e-mail regularily.

-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl
--========GMXBoundary212881092383986
Content-Type: text/plain; name="nfs-oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nfs-oops.txt"

bGludXgtMi42LjgtcmM0LWJrMQoKa2VybmVsOiBWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MyBmaWxl
c3lzdGVtKSByZWFkb25seS4gCmtlcm5lbDogM2M1OXg6IERvbmFsZCBCZWNrZXIgYW5kIG90aGVy
cy4gd3d3LnNjeWxkLmNvbS9uZXR3b3JrL3ZvcnRleC5odG1sIApudHBkWzEwMl06IG5vIElQdjYg
aW50ZXJmYWNlcyBmb3VuZAprZXJuZWw6IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9p
bnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAgCmtlcm5lbDogIHBy
aW50aW5nIGVpcDogCmtlcm5lbDogYzAxNDYyOWIgCmtlcm5lbDogKnBkZSA9IDM3NmM0MDAxIApr
ZXJuZWw6IE9vcHM6IDAwMDAgWyMxXSAKa2VybmVsOiBQUkVFTVBUIFNNUCAgCmtlcm5lbDogTW9k
dWxlcyBsaW5rZWQgaW46IDNjNTl4IAprZXJuZWw6IENQVTogICAgMCAKa2VybmVsOiBFSVA6ICAg
IDAwNjA6W3BhZ2VfYWRkcmVzcysxMS8xNzZdICAgIE5vdCB0YWludGVkIAprZXJuZWw6IEVGTEFH
UzogMDAwMTAyODYgICAoMi42LjgtcmM0LWJrMSkgIAprZXJuZWw6IEVJUCBpcyBhdCBwYWdlX2Fk
ZHJlc3MrMHhiLzB4YjAgCmtlcm5lbDogZWF4OiAwMDAwMDAwMCAgIGVieDogMDAwMDAwMDAgICBl
Y3g6IDAwMDAwMDBhICAgZWR4OiAwMDAwMDAwYSAKa2VybmVsOiBlc2k6IGY3ZTlmMjAwICAgZWRp
OiBmZmZmNzQwMCAgIGVicDogMDAwMDAwMDkgICBlc3A6IGY3NzE1ZjE4IAprZXJuZWw6IGRzOiAw
MDdiICAgZXM6IDAwN2IgICBzczogMDA2OCAKa2VybmVsOiBQcm9jZXNzIG5mc2QgKHBpZDogNzQs
IHRocmVhZGluZm89Zjc3MTUwMDAgdGFzaz1mNzczOTFmMCkgCmtlcm5lbDogU3RhY2s6IGMwMzJi
MGRjIGMyMzQxMDAwIGY3ZTlmMjAwIGZmZmY3NDAwIDAwMDAwMDA5IGMwMWRkZmZjIDAwMDAwMDAw
IGMyMTMwZTg0ICAKa2VybmVsOiAgICAgICAgMDAwMDAwMjAgZjdlOWYyMDAgYzAzYmJkMzggZjc3
MTc4ZWMgZjc3MjgwMTQgYzAxZDQzZWMgZjdlOWYyMDAgYzIxMzBlYjAgIAprZXJuZWw6ICAgICAg
ICBjMjM0MTAwMCBmN2U5ZjI2NCBmN2U5ZjIwMCBmNzcxNzhlYyBjMDNiYmQzOCBjMDMyYTM2MiBm
N2U5ZjIwMCBmNzcyODAxNCAgCmtlcm5lbDogQ2FsbCBUcmFjZTogCmtlcm5lbDogIFtzdmNfdWRw
X3JlY3Zmcm9tKzIzNi82NDBdIHN2Y191ZHBfcmVjdmZyb20rMHhlYy8weDI4MCAKa2VybmVsOiAg
W25mc3N2Y19kZWNvZGVfcmVhZGFyZ3MrMjA0LzI4OF0gbmZzc3ZjX2RlY29kZV9yZWFkYXJncysw
eGNjLzB4MTIwIAprZXJuZWw6ICBbbmZzZF9kaXNwYXRjaCsxMDgvNTEyXSBuZnNkX2Rpc3BhdGNo
KzB4NmMvMHgyMDAgCmtlcm5lbDogIFtzdmNfcHJvY2VzcysxMTcwLzE1MTVdIHN2Y19wcm9jZXNz
KzB4NDkyLzB4NWViIAprZXJuZWw6ICBbbmZzZCs1NjYvMTEyMF0gbmZzZCsweDIzNi8weDQ2MCAK
a2VybmVsOiAgW25mc2QrMC8xMTIwXSBuZnNkKzB4MC8weDQ2MCAKa2VybmVsOiAgW2tlcm5lbF90
aHJlYWRfaGVscGVyKzUvMjBdIGtlcm5lbF90aHJlYWRfaGVscGVyKzB4NS8weDE0IAprZXJuZWw6
IENvZGU6IDhiIDAzIGY2IGM0IDAxIDc1IDFlIDJiIDFkIDEwIDAyIDRhIGMwIGMxIGZiIDA1IGMx
IGUzIDBjIDhkICAK

--========GMXBoundary212881092383986--

