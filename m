Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRCMVcR>; Tue, 13 Mar 2001 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRCMVcJ>; Tue, 13 Mar 2001 16:32:09 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131187AbRCMVbz>;
	Tue, 13 Mar 2001 16:31:55 -0500
X-Sent: 13 Mar 2001 20:35:48 GMT
Date: Tue, 13 Mar 2001 12:37:16 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: [PATCH] 2.4.3-pre3 add PBG4 native LCD mode to modedb.c
Message-ID: <Pine.LNX.4.33.0103131224340.252-200000@desktop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655872-432902778-984515836=:252"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655872-432902778-984515836=:252
Content-Type: TEXT/PLAIN; charset=US-ASCII

The attached patch adds the a new mode to the modedb, used by the ATI,
3Dfx, and Amiga frame buffer devices.  The new mode is the native,
slightly wide resolution of the new Apple laptops.  It isn't obvious how
popular a mode has to be before it goes into modedb.c.

-jwb

--655872-432902778-984515836=:252
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mode.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0103131237160.252@desktop>
Content-Description: Patch to drivers/video/modedb.c
Content-Disposition: attachment; filename="mode.diff"

LS0tIGRyaXZlcnMvdmlkZW8vbW9kZWRiLmMub3JpZwlUdWUgTWFyIDEzIDA0
OjIwOjQzIDIwMDENCisrKyBkcml2ZXJzL3ZpZGVvL21vZGVkYi5jCVR1ZSBN
YXIgMTMgMDQ6MTY6MjAgMjAwMQ0KQEAgLTkxLDYgKzkxLDEwIEBADQogCU5V
TEwsIDYwLCAxMDI0LCA3NjgsIDE1Mzg0LCAxNjgsIDgsIDI5LCAzLCAxNDQs
IDYsDQogCTAsIEZCX1ZNT0RFX05PTklOVEVSTEFDRUQNCiAgICAgfSwgew0K
KwkvKiAxMTUyeDc2OCBAIDU1IEh6LCA0NC4xNTQga0h6IGhzeW5jLCBQb3dl
ckJvb2sgRzQgTENEICovDQorICAgICAgICBOVUxMLCA1NSwgMTE1MiwgNzY4
LCAxNTM4NiwgMTI2LCA1OCwgMjksIDMsIDEzNiwgNiwNCisgICAgICAgIDAs
IEZCX1ZNT0RFX05PTklOVEVSTEFDRUQgDQorICAgIH0sIHsNCiAJLyogNjQw
eDQ4MCBAIDEwMCBIeiwgNTMuMDEga0h6IGhzeW5jICovDQogCU5VTEwsIDEw
MCwgNjQwLCA0ODAsIDIxODM0LCA5NiwgMzIsIDM2LCA4LCA5NiwgNiwNCiAJ
MCwgRkJfVk1PREVfTk9OSU5URVJMQUNFRA0K
--655872-432902778-984515836=:252--
