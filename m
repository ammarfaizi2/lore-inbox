Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbRFBAv4>; Fri, 1 Jun 2001 20:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbRFBAvq>; Fri, 1 Jun 2001 20:51:46 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:15184 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S261824AbRFBAvf>; Fri, 1 Jun 2001 20:51:35 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_OD2AA6I0UCFNK3Q9X1YE"
From: Ben Twijnstra <bentw@chello.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: cs46xx driver in 2.4.5-ac6
Date: Sat, 2 Jun 2001 02:51:24 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01060202512400.01300@beastie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OD2AA6I0UCFNK3Q9X1YE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Alan,

sndconfig still locked up on me with the cs46xx driver in -ac6, but I found 
the culprit. Too lazy to figure out how to officially submit a patch, but the 
body should look like what I attached.

Looks like you're too pessimistic. If everything works OK first time you 
don't believe it. Oh well, looking at your diary, given all those 
contractors I can't blame your mindset ;-)

Grtz,


Ben
--------------Boundary-00=_OD2AA6I0UCFNK3Q9X1YE
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cs46xx.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cs46xx.c.patch"

KioqIGRyaXZlcnMvc291bmQvY3M0Nnh4LmMJU2F0IEp1biAgMiAwMjozODowNiAyMDAxCi0tLSAu
Li9jczQ2eHguYwlTYXQgSnVuICAyIDAyOjQwOjA5IDIwMDEKKioqKioqKioqKioqKioqCioqKiAy
MzEyLDIzMTcgKioqKgotLS0gMjMxMiwyMzE4IC0tLS0KICAKICAJQ1NfREJHT1VUKENTX1dBVkVf
V1JJVEUgfCBDU19GVU5DVElPTiwgMiwgCiAgCQlwcmludGsoImNzNDZ4eDogY3Nfd3JpdGUoKS0g
cmV0PTB4JXhcbiIsIHJldCkgKTsKKyAgICAgICAgIHVwKCZzdGF0ZS0+c2VtKTsKICAJcmV0dXJu
IHJldDsKICBvdXQ6CiAgCXVwKCZzdGF0ZS0+c2VtKTsK

--------------Boundary-00=_OD2AA6I0UCFNK3Q9X1YE--
