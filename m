Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267896AbUHPTUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267896AbUHPTUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267902AbUHPTUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:20:21 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:26803 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S267896AbUHPTUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:20:14 -0400
Date: Mon, 16 Aug 2004 15:20:18 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] net/ipv4/proc.c
Message-ID: <Pine.LNX.4.60.0408161505220.29938@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1463758312-8112700-1092683242=:29938"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1463758312-8112700-1092683242=:29938
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII

Hi,

Between 2.6.8-rc2-bk1 and 2.6.8-rc2-bk2 net/ipv4/proc.c was updated to use 
a new mechanism for outputting /proc/net/snmp and /proc/net/netstat. The 
small patch attached fixes a problem when doing `netstat -s`

cheers,

-- Cal
--1463758312-8112700-1092683242=:29938
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="proc.c.diff"
Content-Transfer-Encoding: BASE64
Content-Description: patch
Content-Disposition: ATTACHMENT; FILENAME="proc.c.diff"

ZGlmZiAtTnVyZCBsaW51eC0yLjYuOC4xL25ldC9pcHY0L3Byb2MuYyBsaW51
eC0yLjYuOC4xLTEvbmV0L2lwdjQvcHJvYy5jDQotLS0gbGludXgtMi42Ljgu
MS9uZXQvaXB2NC9wcm9jLmMJMjAwNC0wOC0xNCAwNjo1NDo0Ny4wMDAwMDAw
MDAgLTA0MDANCisrKyBsaW51eC0yLjYuOC4xLTEvbmV0L2lwdjQvcHJvYy5j
CTIwMDQtMDgtMTYgMTQ6NTk6MDQuMDAwMDAwMDAwIC0wNDAwDQpAQCAtMzMw
LDcgKzMzMCw3IEBADQogew0KIAlpbnQgaTsNCiANCi0Jc2VxX3B1dHMoc2Vx
LCAiXG5UY3BFeHQ6Iik7DQorCXNlcV9wdXRzKHNlcSwgIlRjcEV4dDoiKTsN
CiAJZm9yIChpID0gMDsgc25tcDRfbmV0X2xpc3RbaV0ubmFtZSAhPSBOVUxM
OyBpKyspDQogCQlzZXFfcHJpbnRmKHNlcSwgIiAlcyIsIHNubXA0X25ldF9s
aXN0W2ldLm5hbWUpOw0KIA0K

--1463758312-8112700-1092683242=:29938--
