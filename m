Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbQKCACM>; Thu, 2 Nov 2000 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbQKCACD>; Thu, 2 Nov 2000 19:02:03 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:29589 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129363AbQKCABh>;
	Thu, 2 Nov 2000 19:01:37 -0500
Date: Fri, 3 Nov 2000 02:08:53 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Greg KH <greg@wirex.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre19
In-Reply-To: <20001102132206.B2424@wirex.com>
Message-ID: <Pine.LNX.4.10.10011030203590.31286-300000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1117300962-785922402-973213560=:31286"
Content-ID: <Pine.LNX.4.10.10011030206060.31286@iq.rulez.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1117300962-785922402-973213560=:31286
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.10.10011030206061.31286@iq.rulez.org>

On Thu, 2 Nov 2000, Greg KH wrote:

> Could you send the result of /proc/interrupts and 'lspci -v'?
> Also, have you tried the alternate UHCI controller driver?
> Or tried USB as modules, instead of compiled in?

Here you go. I did work w/ the very same hw with pre15.

I have never really knew what the UHCI JE was all about... So it can be
used in place of the original UHCI? I will make a try. (and why JE?)

--  SaPE

Peter, Sasi <sape@sch.hu>

--1117300962-785922402-973213560=:31286
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=lspci-v
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011030206000.31286@iq.rulez.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=lspci-v

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gNDQwQlgv
WlggLSA4MjQ0M0JYL1pYIEhvc3QgYnJpZGdlIChyZXYgMDIpDQoJRmxhZ3M6
IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMzINCglNZW1v
cnkgYXQgZDAwMDAwMDAgKDMyLWJpdCwgcHJlZmV0Y2hhYmxlKQ0KCUNhcGFi
aWxpdGllczogW2EwXSBBR1AgdmVyc2lvbiAxLjANCg0KMDA6MDEuMCBQQ0kg
YnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiA0NDBCWC9aWCAtIDgyNDQzQlgv
WlggQUdQIGJyaWRnZSAocmV2IDAyKSAocHJvZy1pZiAwMCBbTm9ybWFsIGRl
Y29kZV0pDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIDY2TWh6LCBtZWRpdW0gZGV2
c2VsLCBsYXRlbmN5IDY0DQoJQnVzOiBwcmltYXJ5PTAwLCBzZWNvbmRhcnk9
MDEsIHN1Ym9yZGluYXRlPTAxLCBzZWMtbGF0ZW5jeT0zMg0KCU1lbW9yeSBi
ZWhpbmQgYnJpZGdlOiBkNDAwMDAwMC1kN2ZmZmZmZg0KCVByZWZldGNoYWJs
ZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogZDgwMDAwMDAtZDhmZmZmZmYNCg0K
MDA6MDcuMCBJU0EgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjM3MUFC
IFBJSVg0IElTQSAocmV2IDAyKQ0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRp
dW0gZGV2c2VsLCBsYXRlbmN5IDANCg0KMDA6MDcuMSBJREUgaW50ZXJmYWNl
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjM3MUFCIFBJSVg0IElERSAocmV2IDAx
KSAocHJvZy1pZiA4MCBbTWFzdGVyXSkNCglGbGFnczogYnVzIG1hc3Rlciwg
bWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAzMg0KCUkvTyBwb3J0cyBhdCBmMDAw
DQoNCjAwOjA3LjIgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9u
IDgyMzcxQUIgUElJWDQgVVNCIChyZXYgMDEpIChwcm9nLWlmIDAwIFtVSENJ
XSkNCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5j
eSAzMiwgSVJRIDExDQoJSS9PIHBvcnRzIGF0IGQwMDANCg0KMDA6MDcuMyBC
cmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIDgyMzcxQUIgUElJWDQgQUNQSSAo
cmV2IDAyKQ0KCUZsYWdzOiBtZWRpdW0gZGV2c2VsDQoNCjAwOjBiLjAgUkFJ
RCBidXMgY29udHJvbGxlcjogQ01EIFRlY2hub2xvZ3kgSW5jIFBDSTA2NDgg
KHJldiAwMSkNCglTdWJzeXN0ZW06IFVua25vd24gZGV2aWNlIDc4YzY6Zjc3
NA0KCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5
IDY0LCBJUlEgMTINCglJL08gcG9ydHMgYXQgZDQwMA0KCUkvTyBwb3J0cyBh
dCBkODAwDQoJSS9PIHBvcnRzIGF0IGRjMDANCglJL08gcG9ydHMgYXQgZTAw
MA0KCUkvTyBwb3J0cyBhdCBlNDAwDQoJQ2FwYWJpbGl0aWVzOiBbNjBdIFBv
d2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAxDQoNCjAwOjBmLjAgRXRoZXJuZXQg
Y29udHJvbGxlcjogRGlnaXRhbCBFcXVpcG1lbnQgQ29ycG9yYXRpb24gREVD
Y2hpcCAyMTE0MCBbRmFzdGVyTmV0XSAocmV2IDIwKQ0KCVN1YnN5c3RlbTog
RGlnaXRhbCBFcXVpcG1lbnQgQ29ycG9yYXRpb246IFVua25vd24gZGV2aWNl
IDUwMGENCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0
ZW5jeSAzMiwgSVJRIDEwDQoJSS9PIHBvcnRzIGF0IGU4MDANCglNZW1vcnkg
YXQgZGEwMDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkNCg0KMDA6
MTEuMCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IEVuc29uaXEgRVMx
MzcwIFtBdWRpb1BDSV0NCglTdWJzeXN0ZW06IFVua25vd24gZGV2aWNlIDQ5
NDI6NGM0Yw0KCUZsYWdzOiBidXMgbWFzdGVyLCBzbG93IGRldnNlbCwgbGF0
ZW5jeSAzMiwgSVJRIDExDQoJSS9PIHBvcnRzIGF0IGVjMDANCg0KMDE6MDAu
MCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBNYXRyb3ggR3JhcGhpY3Ms
IEluYy4gTUdBIEcyMDAgQUdQIChyZXYgMDMpIChwcm9nLWlmIDAwIFtWR0Fd
KQ0KCVN1YnN5c3RlbTogTWF0cm94IEdyYXBoaWNzLCBJbmMuIE1pbGxlbm5p
dW0gRzIwMCBBR1ANCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNl
bCwgbGF0ZW5jeSAzMiwgSVJRIDEwDQoJTWVtb3J5IGF0IGQ4MDAwMDAwICgz
Mi1iaXQsIHByZWZldGNoYWJsZSkNCglNZW1vcnkgYXQgZDQwMDAwMDAgKDMy
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkNCglNZW1vcnkgYXQgZDUwMDAwMDAg
KDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkNCglDYXBhYmlsaXRpZXM6IFtk
Y10gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDENCglDYXBhYmlsaXRpZXM6
IFtmMF0gQUdQIHZlcnNpb24gMS4wDQoNCg==
--1117300962-785922402-973213560=:31286
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=procint
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10011030206001.31286@iq.rulez.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=procint

ICAgICAgICAgICBDUFUwICAgICAgIA0KICAwOiAgICA4MDMxNjIxICAgICAg
ICAgIFhULVBJQyAgdGltZXINCiAgMTogICAgICA4OTE1MyAgICAgICAgICBY
VC1QSUMgIGtleWJvYXJkDQogIDI6ICAgICAgICAgIDAgICAgICAgICAgWFQt
UElDICBjYXNjYWRlDQogIDg6ICAgICAgICAgIDEgICAgICAgICAgWFQtUElD
ICBydGMNCiAxMDogICA0MzMyNTgzMyAgICAgICAgICBYVC1QSUMgIGV0aDAN
CiAxMTogICAxMTAwMzQxMSAgICAgICAgICBYVC1QSUMgIHVzYi11aGNpLCBl
czEzNzANCiAxMjogICAgMTM0NjUzMyAgICAgICAgICBYVC1QSUMgIGlkZTIs
IGlkZTMNCiAxMzogICAgICAgICAgMSAgICAgICAgICBYVC1QSUMgIGZwdQ0K
IDE0OiAgICAgMjM4OTM1ICAgICAgICAgIFhULVBJQyAgaWRlMA0KIDE1OiAg
ICAgNTEzODQxICAgICAgICAgIFhULVBJQyAgaWRlMQ0KTk1JOiAgICAgICAg
ICAwDQo=
--1117300962-785922402-973213560=:31286--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
