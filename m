Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVAENYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVAENYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVAENYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:24:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:15019 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262364AbVAENYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:24:33 -0500
Date: Wed, 5 Jan 2005 14:24:30 +0100 (MET)
From: "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>
X-X-Sender: colbuse@ensisun
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISAPnP trivial bug 
Message-ID: <Pine.GSO.4.40.0501051423400.19563-200000@ensisun>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-559023410-1804928587-1104931310=:19563"
Content-ID: <Pine.GSO.4.40.0501051423401.19563@ensisun>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Wed, 05 Jan 2005 14:24:30 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1104931310=:19563
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.40.0501051423402.19563@ensisun>


There is a trivial bug in the file sound/isa/gus/interwave.c .
The variable isapnp is defined only if CONFIG_PNP is enabled, but it is
always used few lines after.

This patch, relative to 2.6.10, fixes it.

Regards,

-- 
Emmanuel Colbus
Club GNU/LINUX
ENSIMAG - Departement Telecommunications

---559023410-1804928587-1104931310=:19563
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=int_patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.40.0501051421500.19563@ensisun>
Content-Description: interwave.c patch
Content-Disposition: ATTACHMENT; FILENAME=int_patch

LS0tIGEvc291bmQvaXNhL2d1cy9pbnRlcndhdmUuYwlGcmkgRGVjIDI0IDIy
OjM0OjU4IDIwMDQNCisrKyBiL3NvdW5kL2lzYS9ndXMvaW50ZXJ3YXZlLmMJ
V2VkIEphbiAgNSAxNDowNjo1MyAyMDA1DQpAQCAtNzksOCArNzksMTAgQEAN
CiBNT0RVTEVfUEFSTV9ERVNDKGlkLCAiSUQgc3RyaW5nIGZvciBJbnRlcldh
dmUgc291bmRjYXJkLiIpOw0KIG1vZHVsZV9wYXJhbV9hcnJheShlbmFibGUs
IGJvb2wsIE5VTEwsIDA0NDQpOw0KIE1PRFVMRV9QQVJNX0RFU0MoZW5hYmxl
LCAiRW5hYmxlIEludGVyV2F2ZSBzb3VuZGNhcmQuIik7DQorI2lmZGVmIENP
TkZJR19QTlANCiBtb2R1bGVfcGFyYW1fYXJyYXkoaXNhcG5wLCBib29sLCBO
VUxMLCAwNDQ0KTsNCiBNT0RVTEVfUEFSTV9ERVNDKGlzYXBucCwgIklTQSBQ
blAgZGV0ZWN0aW9uIGZvciBzcGVjaWZpZWQgc291bmRjYXJkLiIpOw0KKyNl
bmRpZg0KIG1vZHVsZV9wYXJhbV9hcnJheShwb3J0LCBsb25nLCBOVUxMLCAw
NDQ0KTsNCiBNT0RVTEVfUEFSTV9ERVNDKHBvcnQsICJQb3J0ICMgZm9yIElu
dGVyV2F2ZSBkcml2ZXIuIik7DQogI2lmZGVmIFNORFJWX1NUQg0K
---559023410-1804928587-1104931310=:19563--
