Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSBDW1p>; Mon, 4 Feb 2002 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289224AbSBDW1Z>; Mon, 4 Feb 2002 17:27:25 -0500
Received: from maile.telia.com ([194.22.190.16]:8938 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S289216AbSBDW1R>;
	Mon, 4 Feb 2002 17:27:17 -0500
Message-Id: <200202042227.g14MRFN12329@maile.telia.com>
X-KMail-Redirect-From: Roger Larsson <roger.larsson@norran.net>
Subject: New VM Testcase (2.4.18pre7 SWAPS) (2.4.17-rmap12b OK)
From: Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson
	<roger.larsson@norran.net>)
Date: Mon, 4 Feb 2002 23:24:11 +0100
To: list linux-kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BW41Q3VQ2036LQN91ETS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BW41Q3VQ2036LQN91ETS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

When examining Karlsbakk problem I got into one quite different myself.

I have a 256MB UP PII 933 MHz.
When running the included program with an option of 200
(serving 200 clients with streaming data á 10MB... on first run
it creates the data, from /dev/urandom - overkill from /dev/null is ok!)

ddteset.sh 200
[testcase initially written by Roy Sigurd Karlsbakk, he does not get
into this - but he has more RAM]

the 2.4.18pre7 goes into deep swap after awhile .
It is impossible to start a new login, et.c. finally
the dd processes begins to be OOM killed... not nice...

the 2.4.17-rmap12b handles this MUCH nicer!

/RogerL

--
Roger Larsson
Skellefteå
Sweden



--------------Boundary-00=_BW41Q3VQ2036LQN91ETS
Content-Type: application/x-shellscript;
  charset="iso-8859-1";
  name="ddtest.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ddtest.sh"

IyEvYmluL2Jhc2gKTUFYPTEwMApCUz0kKCgxMDI0ICogMjA0OCkpCkNPVU5UPTEwCkZQQVRIPS90
bXAKCmNhc2UgJCMgaW4KICAgICAgICAwKQogICAgICAgICAgICAgICAgaT0kQ09VTlQKICAgICAg
ICAgICAgICAgIDs7CgogICAgICAgIDEpCiAgICAgICAgICAgICAgICBpPSQxCiAgICAgICAgICAg
ICAgICA7OwogICAgICAgICopCiAgICAgICAgICAgICAgICBwcmludGYgIkVycm9yOlxuU3ludGF4
OiAkMCBbIG51bWZpbGVzIF1cbiIKICAgICAgICAgICAgICAgIGV4aXQKICAgICAgICAgICAgICAg
IDs7CmVzYWMKCmlmIFtbICRpIC1sdCAxIF1dOyB0aGVuCiAgICAgICAgcHJpbnRmICJDYW4ndCBy
ZWFkICRpIGZpbGVzXG4iCiAgICAgICAgZXhpdApmaQoKaWYgdGVzdCBcISAtZiBgcHJpbnRmICIl
cy9maWxlJTA0ZC5tcDAiICRGUEFUSCAkaWA7IHRoZW4KICAgICAgICBjPSRpCiAgICAgICAgZWNo
byAiV3JpdGluZyAkYyBmaWxlcy4uLiIKCiAgICAgICAgd2hpbGUgW1sgJGMgLWd0IDAgXV07IGRv
CiAgICAgICAgICAgICAgICBmaWxlPWBwcmludGYgIiVzL2ZpbGUlMDRkLm1wMCIgJEZQQVRIICRj
YAogICAgICAgICAgICAgICAgdG91Y2ggJGZpbGUKICAgICAgICAgICAgICAgIGRkIGlmPS9kZXYv
dXJhbmRvbSBvZj0kZmlsZSBicz0kQlMgY291bnQ9JENPVU5UCiAgICAgICAgICAgICAgICBjPSQo
KCAkYyAtIDEgKSkKICAgICAgICBkb25lCmZpCgpwcmludGYgIlJlYWRpbmcgJGkgZmlsZXMuLlxu
IgoKd2hpbGUgW1sgJGkgLWd0IDAgXV07IGRvCiAgICAgICAgZmlsZT1gcHJpbnRmICIlcy9maWxl
JTA0ZC5tcDAiICRGUEFUSCAkaWAKICAgICAgICBkZCBpZj0kZmlsZSBvZj0vZGV2L251bGwgYnM9
JEJTICYKICAgICAgICBpPSQoKCAkaSAtIDEgKSkKZG9uZQo=

--------------Boundary-00=_BW41Q3VQ2036LQN91ETS--
