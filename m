Return-Path: <linux-kernel-owner+w=401wt.eu-S1754150AbWLXG7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbWLXG7E (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 01:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbWLXG7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 01:59:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:18293 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbWLXG7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 01:59:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=EwNRrVmKa9utVGIeu2N59+qbETnljtr8ljMtjaQprFahudCurIl4ssUo8SLO7xlFGxQc4bWoTTFlUDmyldAKhjkWOO7ukQs/iN0lFpbElWTW/5Ki7HRm/m3jM5dww3/jEshiT8jaYHDxkVggJxZEPXAyh8H3juBv3hM5XL0NjM8=
Message-ID: <8bd0f97a0612232259k5a0ac0c8k8dceee2227678a86@mail.gmail.com>
Date: Sun, 24 Dec 2006 01:59:00 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: dignome@gmail.com
Subject: cypress_m8 spews garbage on ppc64 but is ok on x86
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_60975_26077775.1166943540146"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_60975_26077775.1166943540146
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

anyone tried using the cypress_m8 usb serial cable on a G5 ?  just
tried it on a ppc64/2.6.19.1 kernel and all i get back is garbage when
hooked up to serial console of a board running at 57600 baud

plugged the same cable into my x86 machine and it works OK there
Bus 001 Device 010: ID 04b4:5500 Cypress Semiconductor Corp. HID->COM
RS232 Adapter

plugged a pl2303 into the ppc64 and that worked fine too
Bus 001 Device 011: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port

$ uname -a
Linux G5 2.6.19.1 #2 SMP Sun Dec 24 00:53:03 EST 2006 ppc PPC970MP,
altivec supported PowerMac11,2 GNU/Linux

$ stty -F /dev/ttyUSB0
speed 57600 baud; line = 0;
flush = ^U; min = 1; time = 5;
ignbrk -brkint -icrnl ixoff -imaxbel
-opost -onlcr
-isig -icanon -iexten -echo -echoe -echok -echoctl -echoke

find attached logs after doing `modprobe cypress_m8 debug=1`
 * setup of /dev/ttyUSB0 to proper serial settings
 * the board running `yes` and spewing "y" over the serial console to my machine
-mike

------=_Part_60975_26077775.1166943540146
Content-Type: application/x-bzip2; name=cypress-yes.log.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew341at1
Content-Disposition: attachment; filename="cypress-yes.log.bz2"

QlpoOTFBWSZTWZb7UTsAjHjfxQBwYCf/8hAQCgC+79/wABAQUACAYAffPQAAAH0AAooFSQwGgNAA
BpoNANAGgwGgNAABpoNANAGgwGgNAABpoNANAGgYqTahpiZDIaYBAAAbUE1VJkh5Ke1Q2kGCMgDQ
0NDQKUkEECaZJNG0QNNNDJkD1NkId4g+7ppt/D35ftyYZmM3zOaZgzEMWVbG0Rg2yozJjMxZhDSk
gtgfY3diTAO0AfTiSgwkEkF5AgtLmQLfXZrsfTdHrlUzKeco856KGu7p05u70+nicnCq4wOqh3Pj
ngI8DwdO15O87d5XGKnbYRl2g6YqzKdrjxdZorrkmMp5ZrFdijt3Ydk75Kt3g6O1rqtsKN1DpOZR
rnh11OUjdc4QxvpyuuTfEawL3hB8cD1R977n72uLY32btZQfYbOMUN8mapG3MAaqgcbw+d81VV1x
0tn2n3X73PLhw3bt3JxOOG2+buba2bHFztpqbzabm84nJw25kNKHIjlI3qHMo5lHJxnJqczmc3K5
rjJLWE5qjaE5pHJRyicpHMtZQcqjlQ5iOSjgRzKN8Q2kQ3jcPnf2iDPt1EH45szb8t2efWvIvA8Y
P1CH8c3o+OE6YVc7aI9T1ykYyzJRvlVDRRwGP1FV7IsFVgbbNQdKkd8ils01Ie21BypV+HNpSrFV
VxK3M6FGjElMpHbKu2DbGMc0lXKHBtjM5LWM3JV0o4kQxSr4NVQNJBvrhIPySDVQj2/dSpLz4XPi
syxfn7vxgh7JB+nwJ9eV0M38qXR46pB2zalSXyahDvSpL12bOX6JBmor8YA+HySD02qSDZKQbpSD
vlINJSDIIcqfXDID5+sNxepZJWHEWgg/kkGQ+xVVYKrmDi0i2mCq6GujP0MzJmZhN0UObFKuIzmD
LrilXSRD6q1SonAbakq+aGtUr5NstEqxtmRRtq0oYs01VpZk1hhhsFFuEyqB11d6xkxKlskHsiVW
d3RlBrDTIozJDGVJb6jvXJtEGFBmIKXClD80gyRD/KQf+SD9hIPV86IPTVUqjZj1rvih3xUaykYx
jFDMIZhSZWYw3SDb5Zsz3JB0og/miVWxIPXukHdEqvqJB570qJ2bAonfKQYV+qSq8M+2kqbO6QcX
90gx/pEqsqoPP8K6UQbJB6JBnKJVentnP9Po3pUlzBnwog9Pb/jsvdINqVKbJSDir+ykGG7hmUCt
rSywpkRVcUg7JBvSpLW4cIlV4pB3b6pUl8Na6exIOj5Mur6YiVXd4kg+97olV5Eg6FBokG7dIOyJ
VdvWlSXZv5jp7oKWkg7aUg3apUl6fV0eEoPBv6Qh1eT17O77Eg52VKscSgVrYkJN5CTZoSDmiqjZ
Eqvo80Sq08WFIM1SrW9GNja3LtlIMCgVulIMrdPXKQYW/IhJhclIUddOnWEPJy9CQdHxSDr8KVJZ
3cNv6pB4eXPpt5dHfZIN0g3byEm+y1lINSEmdnKQeS00kquCAl5qCTbZqP+LuSKcKEhLfaidgA==

------=_Part_60975_26077775.1166943540146
Content-Type: application/x-bzip2; name=cypress-setup.log.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew341h8t
Content-Disposition: attachment; filename="cypress-setup.log.bz2"

QlpoOTFBWSZTWQcT+aYAWaJfgAAQQG//0hIACgC/79/wUAXeAAAAAAABgDTQ0aMRkA0AGhhgDTQ0
aMRkA0AGhhgDTQ0aMRkA0AGhhgDTQ0aMRkA0AGhgUqIIBBpT0BGgZR4o8ppyIq/Vp2x31M4+X76e
mWcbz7aWMUQzhVMYlLG5wY1Y6NdfY+fHG7DC9ZxnDGjnh/WuVSrVu9WizoxdsPCvmRVhqZIq+x89
TRqvvfX6m7iWrDiam5tvvFVaGD3LzZV1UVe9YIpTDrvimDd+7LRlRVkwoq+jgwRV3UVcLRhyYuDg
cmNOReDretKBooq9Gz7Ghwd9ThHRmJVyurTQydDNIHW3ZVsubLlrhjgcGrP4cMsLuoqxn4P5fs4u
bmZL4qKupwggzJQ228JKHT6yUNZKG9Uq4sIwEkv7PRgFWin6sBJL+2zR+x8l2m7Z81FWGZfRg2l+
WtXLjMWc42MzVc5fNqsmCKvvTd6miSrzkocJ7G8W5FWBKsMEtlRV9VFWH2UVf+UVf0/D6DkkVe1P
fLdkfwIq+LJQLAxE2DE1YLIlW74pFWwir8EI8EirzfTx7GR/Oj/vgJV9bRzdJ4SUPJIq1p+Du9XH
QavjT8SUNEir8+j031GOSRV20fpqXznkoqy1li0V+VFWaneShggHBwMYHsLqyxcxFWwlXVRVplqw
cZKHf2savZ/hq8mPRs9XuemybCKvy5dmvuWzLg9XZXNRVg2chkhG6n+SUMOvbdEi+7fDCMsVgeDZ
5n9sOY8RrTfCvUxSVe/qoq6xjHkoqytyEeDuoq8x185uefky9q4s8TDng5JFXIzMy93ijWN2LqX8
HqZiodHqeVIq+C64mCwfBjCCO6RVxc6SrRIq3b+rPBUq4+MlDwah1Rs6tMPgMMYLmwzOjEWmDRRV
pNxk0VFW4dF6GlGwajiKqyNnNjuqBujxeydDkwfJlhRVvpSB1Z18tgkXmyeTccLS6iKurRyCRYLy
3IR8iyeclDRHEcA4jSKhsOqoHkdfbtdWbi3DxOODDzp6atnfpJQ1TAwoRdpKGzsXkPZJQzLvoyGK
dPGEi6tDk0ZxOdIHR2aPE7HbVy4MpFW4cxKtWLCa+DqHRwPR5KKtOZhxOF1YOM/RWy8bs6BxOzSt
lFWWRxUVanFw2njl3GLxOXFO8lDwOclDoww26F8paHApV4KUDo4H/xdyRThQkAcT+aY=
------=_Part_60975_26077775.1166943540146--
