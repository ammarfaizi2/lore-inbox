Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTAaVyn>; Fri, 31 Jan 2003 16:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTAaVym>; Fri, 31 Jan 2003 16:54:42 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:13577 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262469AbTAaVyl>; Fri, 31 Jan 2003 16:54:41 -0500
From: Robert Bisping <rbisping@mindspring.com>
Reply-To: rbisping@mindspring.com
To: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
Subject: Re: yenta-cardbus IRQ0
Date: Fri, 31 Jan 2003 16:58:30 -0500
X-Mailer: KMail [version 1.3.2]
References: <E18eXoy-0000iL-00@tisch.mail.mindspring.net> <55699.141.108.7.31.1044021002.squirrel@webmail.roma2.infn.it>
In-Reply-To: <55699.141.108.7.31.1044021002.squirrel@webmail.roma2.infn.it>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_IDMLHOWCJZ5I7X3293WO"
Message-Id: <E18ejGW-0000bd-00@maynard.mail.mindspring.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_IDMLHOWCJZ5I7X3293WO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Friday 31 January 2003 08:50, you wrote:
> <quote who="Robert Bisping">
>
> > i have been trying to set up a cardbus card on my thinkpad 760ED for
> > about  the last month and it keeps coming up with IRQ0 and telling me it
> > cant find a  irq for pin A. what would be causing this and how do I
> > correct it i have  already tried APCI and it does not work on my laptop
> > so that is no help. I  have compiled SMP into the kernel though I dont
> > have a dual processor (of  course) to gain the added functionality. I
> > have recompiled my kernel about  150 times with different setting hoping
> > it might just be a conflict in the  kernel with no luck.  I looked at the
> > yenta driver it's self and noticed that  it accepts IRQ0 as a valid irq
> > but that appears to mean no irq at all. which  config file would i use to
> > force it to set a irq?
> >
> >
> > Thanx for any assistanc you might give
>
> plz send an lspci -vv -xxx -s *your dev*
>
> what kernel are you using ?

i am using 2.4.18 and here is lspci
--------------Boundary-00=_IDMLHOWCJZ5I7X3293WO
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cardbuspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cardbuspci.txt"

MDA6MDIuMCBDYXJkQnVzIGJyaWRnZTogVGV4YXMgSW5zdHJ1bWVudHMgUENJMTEzMCAocmV2IDA0
KQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KCVN0YXR1czogQ2FwLSA2Nk1o
ei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLQoJTGF0ZW5jeTogMTY4LCBjYWNoZSBsaW5lIHNpemUgMDgK
CUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAwCglSZWdpb24gMDogTWVtb3J5IGF0IDEw
ODEyMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQnVzOiBwcmltYXJ5
PTAwLCBzZWNvbmRhcnk9MDEsIHN1Ym9yZGluYXRlPTAzLCBzZWMtbGF0ZW5jeT0xNzYKCU1lbW9y
eSB3aW5kb3cgMDogMTAwMDAwMDAtMTAzZmYwMDAgKHByZWZldGNoYWJsZSkKCU1lbW9yeSB3aW5k
b3cgMTogMTA0MDAwMDAtMTA3ZmYwMDAKCUkvTyB3aW5kb3cgMDogMDAwMDQwMDAtMDAwMDQwZmYK
CUkvTyB3aW5kb3cgMTogMDAwMDQ0MDAtMDAwMDQ0ZmYKCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJS
LSBJU0EtIFZHQS0gTUFib3J0LSA+UmVzZXQrIDE2YkludCsgUG9zdFdyaXRlKwoJMTYtYml0IGxl
Z2FjeSBpbnRlcmZhY2UgcG9ydHMgYXQgMDAwMQowMDogNGMgMTAgMTIgYWMgMDcgMDAgMDAgMDIg
MDQgMDAgMDcgMDYgMDggYTggODIgMDAKMTA6IDAwIDIwIDgxIDEwIDAwIDAwIDAwIDAyIDAwIDAx
IDAzIGIwIDAwIDAwIDAwIDEwCjIwOiAwMCBmMCAzZiAxMCAwMCAwMCA0MCAxMCAwMCBmMCA3ZiAx
MCAwMCA0MCAwMCAwMAozMDogZmMgNDAgMDAgMDAgMDAgNDQgMDAgMDAgZmMgNDQgMDAgMDAgZmYg
MDEgYzAgMDUKNDA6IDAwIDAwIDAwIDAwIDAxIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwCjUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo2
MDogMjAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKNzA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCjgwOiAyMCAzMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo5MDogMDAgODMgNzIgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKYTA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApjMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAKZDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMApmMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKCjAwOjAyLjEgQ2FyZEJ1cyBicmlkZ2U6IFRleGFzIEluc3RydW1lbnRzIFBDSTExMzAg
KHJldiAwNCkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lO
Vi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItCglTdGF0dXM6IENh
cC0gNjZNaHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxU
QWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0KCUxhdGVuY3k6IDE2OCwgY2FjaGUgbGluZSBz
aXplIDA4CglJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJUlEgMAoJUmVnaW9uIDA6IE1lbW9y
eSBhdCAxMDgxMTAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10KCUJ1czog
cHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA0LCBzdWJvcmRpbmF0ZT0wNiwgc2VjLWxhdGVuY3k9MTc2
CglNZW1vcnkgd2luZG93IDA6IDEwYzAwMDAwLTEwZmZmMDAwIChwcmVmZXRjaGFibGUpCglNZW1v
cnkgd2luZG93IDE6IDExMDAwMDAwLTExM2ZmMDAwCglJL08gd2luZG93IDA6IDAwMDA0ODAwLTAw
MDA0OGZmCglJL08gd2luZG93IDE6IDAwMDA0YzAwLTAwMDA0Y2ZmCglCcmlkZ2VDdGw6IFBhcml0
eS0gU0VSUi0gSVNBLSBWR0EtIE1BYm9ydC0gPlJlc2V0LSAxNmJJbnQrIFBvc3RXcml0ZSsKCTE2
LWJpdCBsZWdhY3kgaW50ZXJmYWNlIHBvcnRzIGF0IDAwMDEKMDA6IDRjIDEwIDEyIGFjIDA3IDAw
IDAwIDAyIDA0IDAwIDA3IDA2IDA4IGE4IDgyIDAwCjEwOiAwMCAxMCA4MSAxMCAwMCAwMCAwMCA4
MiAwMCAwNCAwNiBiMCAwMCAwMCBjMCAxMAoyMDogMDAgZjAgZmYgMTAgMDAgMDAgMDAgMTEgMDAg
ZjAgM2YgMTEgMDAgNDggMDAgMDAKMzA6IGZjIDQ4IDAwIDAwIDAwIDRjIDAwIDAwIGZjIDRjIDAw
IDAwIGZmIDAyIDgwIDA1CjQwOiAwMCAwMCAwMCAwMCAwMSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMAo1MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAKNjA6IDMzIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
CjcwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo4MDog
MjAgMTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKOTA6IDAwIDgy
IDcyIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmEwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApiMDogMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAKYzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCmQwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMAplMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAKZjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwCgo=

--------------Boundary-00=_IDMLHOWCJZ5I7X3293WO--
