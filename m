Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTBDEWr>; Mon, 3 Feb 2003 23:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTBDEWr>; Mon, 3 Feb 2003 23:22:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6917 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267120AbTBDEWq>; Mon, 3 Feb 2003 23:22:46 -0500
Date: Mon, 3 Feb 2003 20:32:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: Adam Radford <aradford@3WARE.com>
Subject: linux-2.4.18-3ware-fake.patch, 8500 series
Message-ID: <Pine.LNX.4.10.10302032024390.2810-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/MIXED; BOUNDARY="1430322656-362363177-1044332870=:2810"
Content-ID: <Pine.LNX.4.10.10302032030270.2810@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-362363177-1044332870=:2810
Content-Type: text/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.4.10.10302032030271.2810@master.linux-ide.org>


This patch addresses two primary commands not supported.
This is to reduce noise pollution in logs.


	MODE_SENSE:
	VERIFY:


Are not supported in the driver and would normally make noise but this
effects performance under some environments.



Cheers,

Andre Hedrick
LAD Storage Consulting Group

--1430322656-362363177-1044332870=:2810
Content-Type: text/PLAIN; CHARSET=US-ASCII; NAME="linux-2.4.18-3ware-fake.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.44.0302031927140.7117@autobuild.linux-ide.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="linux-2.4.18-3ware-fake.patch"

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS8zdy14eHh4LmMub3JpZwkyMDAyLTEy
LTA5IDE3OjQzOjIyLjAwMDAwMDAwMCAtMDgwMA0KKysrIGxpbnV4L2RyaXZl
cnMvc2NzaS8zdy14eHh4LmMJMjAwMi0xMi0wOSAxNzo0NTo0My4wMDAwMDAw
MDAgLTA4MDANCkBAIC0yNDM4LDYgKzI0MzgsMTUgQEANCiAJCQlkcHJpbnRr
KEtFUk5fTk9USUNFICIzdy14eHh4OiB0d19zY3NpX3F1ZXVlKCk6IGNhdWdo
dCBUV19TQ1NJX0lPQ1RMLlxuIik7DQogCQkJZXJyb3IgPSB0d19pb2N0bCh0
d19kZXYsIHJlcXVlc3RfaWQpOw0KIAkJCWJyZWFrOw0KKw0KKwkJLyogRklY
TUU6IEZha2Ugb3IgTGllIGJ1dCBGaXhNZSAqLw0KKwkJY2FzZSBNT0RFX1NF
TlNFOg0KKwkJY2FzZSBWRVJJRlk6DQorCQkJdHdfZGV2LT5zdGF0ZVtyZXF1
ZXN0X2lkXSA9IFRXX1NfQ09NUExFVEVEOw0KKwkJCXR3X3N0YXRlX3JlcXVl
c3RfZmluaXNoKHR3X2RldiwgcmVxdWVzdF9pZCk7DQorCQkJU0NwbnQtPnJl
c3VsdCA9IChESURfQkFEX1RBUkdFVCA8PCAxNik7DQorCQkJZG9uZShTQ3Bu
dCk7DQorCQkJYnJlYWs7DQogCQlkZWZhdWx0Og0KIAkJCXByaW50ayhLRVJO
X05PVElDRSAiM3cteHh4eDogc2NzaSVkOiBVbmtub3duIHNjc2kgb3Bjb2Rl
OiAweCV4XG4iLCB0d19kZXYtPmhvc3QtPmhvc3Rfbm8sICpjb21tYW5kKTsN
CiAJCQl0d19kZXYtPnN0YXRlW3JlcXVlc3RfaWRdID0gVFdfU19DT01QTEVU
RUQ7DQo=
--1430322656-362363177-1044332870=:2810--
