Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRBFIkb>; Tue, 6 Feb 2001 03:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129739AbRBFIkV>; Tue, 6 Feb 2001 03:40:21 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:14608 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S129652AbRBFIkE>; Tue, 6 Feb 2001 03:40:04 -0500
Date: Tue, 6 Feb 2001 05:40:40 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops on UHCI module unload (2.4.2-pre1)
Message-ID: <20010206054040.B692@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When trying to figure out how to get USB to work (it was the MPS
setting, more in other post) I got a repeatable Oops (is it an
oops? it doesn't say "Oops!" like I thought they do). That is,
I'd boot, modprobe uhci, plug something in, get lots of timeouts,
unplug the something, modprobe -r uhci. Oops.

Attached are two ksymoops outputs, for the two times I did this.
I stopped modprobe -r'ing after that, then fixed the problem wrt
timeouts, and am now unable to reproduce the bug (even going back
to MPS 1.4).

Let me know if there's anything else of use I can provide, and if
I got the ksymoops thing right :)

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
Amnesia used to be my favorite word, but then I forgot it.

--x+6KMIRAuhnl3hBn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ksymoops.out.1.gz"
Content-Transfer-Encoding: base64

H4sICB+ufzoAA2tzeW1vb3BzLm91dC4xAK1XbW+jOBD+zq+YD3dSutkGm7dA2kY6Vburk+7U
6nq9L6sqMvbQciHAYeh1//3ZDoGEtDkqdYSCx3jmGc88Y8ha/tgURSnBmbmzORQ5pEEYKM2b
OedlhXS1mQHclHVa5BIaicICLed/wURgwpqsPmtn1mA/s8rOikd73Xq1HUIocYhHPJf6zkzP
S5jIEnmapCh2ptn/m24K0WT4mvHNK3O/vzJ3Z1lfqqqoYIIvJcvFqoj/Rl7LswVwludFDbJm
9cTO0thu0ew+D/YaqxwzW1TpM1bSbmRsN088nRVnkCinevzh/mXMiwo7iK36kShpXja1WqcL
i887oJ3+8UjmdwdjFOsrxgAeEG/hOguHQNxUBa8YTxlsXSzgPmdxhlAX8KTiUKPtAyjZY5o/
QoX/NChrYDU8p1XdsAyYEBVKCYKSJIkwHIOi17oc6Zi1n0qBcAWE+jwmgTvG5EaRegFEyZjV
17f3C83aUdF8+fXWLNYds/h+udvI8sG6lzpBbaNKSKpiA7sOg/MaMEtc5zx1VcufM9D3UXhf
f/vl253ZjGrRcTbIXhZtOUSoYsX4ZZsNLVrnne4FWhdK54lPwsAZlTGUqTIQzHeRc+NgoMfl
IaAsd8/DUQDClI+a4PuhbIdjPNyqGc3K9VMTC5iUqViAGzqfdSPxtWIzXpmAVIBnY/zdabM+
S1sGY+AfzswDtV8uIqR646HXZoCjQxLGSJ+TMZCtbPMWczNwjLtuhjg+c3nnl+6KQPpB9+jd
kK942RsMotlfbHKTkGgU5DXLMvhTzeEC2n5SaV0+tIrOaKdop3tK5HWKF3PaKb7vzzslYAFT
yjt2v7WLQq93H3C/jyJMwt59FAa8X4bERL51uKqfKmRi6hHbD8ZFcF0IlYYwBo8AJZAkIBSN
XODaDLgLoYA4AFOH9opD1X565fayrOVSnVEX3RELl9/bl9mDuq+aPEvz9aqp4imNbMf3lmrH
l1daLFOFi57aJyyFMd23MNTvLWZVIVjNZqrdqnrqBsSmSSAOLAxF3sRwPHqEoUs+sOBFXldF
ttrIx+k8tKNDA02LgYHEetW+sqZOZLvkwEBTZ2CQ478r9YJOOU5pbNMoPLTQ/Dph4Tt4bKO5
tZ+rvUwFnk3p/BBBke8Ewpx6xwiao29Wg3KcH5dDM/mNoEJ+HJSi+omgQh61QWlKX8A76Nid
MJcrReTl4v0e9OtZd3PXR0eyKZ7NqhdKJj+r1+XZZ/3bd8Ih5JBz+5C8g3Q15LZjXxOuzzmA
Txpo4D844R87/77Z0u4sOBLFaX37ibx4ajOyHGCc6jTaYYQaQx0zb0iFtb4NXA/pv+/a6VxH
Jvyj42snmXJjKqILIlNdEJkeAiXDLtgHCjugRAMNTsXj0qs8JUZQmNpbluUB6m9wCamUDQr1
X+wPlOZbbsN+gP4Ij1GlIEv1F/LM+g/l6fakzw0AAA==

--x+6KMIRAuhnl3hBn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ksymoops.out.2.gz"
Content-Transfer-Encoding: base64

H4sICA23fzoAA2tzeW1vb3BzLm91dC4yAL1X/2+jNhT/PX/F+2GT0ss12EAISXuRptPdNGlT
q3XdfjhVyNiPhIUAw9Br//vZhpCEpDm6nWpFxc/4fT7P75vpWj5vsiyXYI+d8RSyFGLP95Tk
ju3LvEAabMYAN3kZZ6mESqIYgB6Xf8JQYMSqpLxoVtZgPbLCSrKltW5QLZsQSmziUjLxiT/W
6xKGMkceRzGKrWrybdVNJqoETynfnFj77cTa3WDwqSiyAob4lLNUBFn4N/JSXsyBszTNSpAl
K4dWEodWw2bt/GCtsUgxsUQRP2IhrUqGVrXi8Ti7gEiB6vl3x5chzwpsKWpx8Bcr0jhdnuCp
Z9CTIsXSyvM8UHFMWKloDEutB3svYMUk8BVLlyhAxilHSDImvqsdoRQBzzb5oRHb1bewQB+Y
yeeUH/vBLL+VDUtMsYhPWNG8eAs7ZLLqGKBXvsm8YXmg6zcos6DW2+X+hpV8ZfYr5QZU1wyU
GTCo0vifCrfrtcGq7/xRMEWyYc+gIUKEApOYhQmO/wdpXUX/lfczhgAuUDKf+HObQFgVGVfb
Ywa1I+dwn+qtmkD5SqhZ/QJyttQWF6goZQmshMe4KCuWABOiQClBUEpnM/T7sAhKIsGR9tn7
LhcIH4DQCQ+J5/RRuVE9eA5EjT67P97ez3WT7WXNp19uzWbd4OdfrrcHWTwM7qV2UHOvSIiK
bAPbCwEuS8AkcuzL2FE31CUD/ezF9/nXn36+M4dRN0o/HWRP8yYcwle2YvhUe0MPLfNWdj0t
CyVzOp0R5L08hjJWCkhxipwbgI4c5oeEMt++93sRCBM+aozfTWUz7YNwq1Z0Vq5XVShgmMdi
DtSZzqbv9U3G1yqf8YMxSZl40QfxTqvt/FTnMHqT/RVKqKdOzCOf2nriu40PuO2EU64mW6/0
YWxG7biQm4ln0NoVYk+Yw1tYuo0C2U22r17NeAJkb9IxZn+z8UxEZr2KjyVJ3bLm0JST8uni
wQi1OxuhxtwTZm4rKF/QVogmk2kLQJjHVHH2P3ut5viuu8PgE9IKduTv0FUR8902JMbwGjAo
VwUyMXKJNfF6GfAxE8oJfgguUfsgikCoDHKAu0Bc4A74AkIPTBCaX+ir2tM7zW8wWCxUf7pq
2ytcf2lujAf1DKo0idN1UBXhiM4se+Iu1HmvP+gxMCG42iX1GU1hVHcaTdLvNMZFJljJxqrQ
inLkeMSikScWBxwqlC9z2C7tcNTx7mjwLC2LLAk2cjma+tbsUEHnREdBYhk019XInlkOOVDQ
edNRSPGr+pB8jDmOaGjRmU8Ozq2T64zGxMZjHZ1Z+77a85TnWpRODxlU6p1hmFL3mEFn6IvR
oByn3XDUefyCUT4/Nkol+hmjfD5rjNIZfQWvSMe2u1wHKpEX89cj6KtZ13JbRkdjkz2aXU+U
DH9UV+XFe/13VwmHlN2c26fkLaWjKeuCPTW4bnIA7zRRB987g48t/sQcadsKjobKaf34gTy5
6jAy73CcqzTacviaQ3WZF0aBpX50oLvpvw9tt9AzY/5R99qORMGYiOiAyFgHRMaHRFG3CvaJ
/JYo0kSHTfFE6JWfIjNQmNgPBoMpfK2/ySWoz16wAfV/wxJiKSsU6qv6d5Tms+7kd/W/rS0c
PIkQAAA=

--x+6KMIRAuhnl3hBn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
