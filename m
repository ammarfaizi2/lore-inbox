Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWF3Ekf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWF3Ekf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 00:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWF3Ekf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 00:40:35 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:31169 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932104AbWF3Eke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 00:40:34 -0400
Date: Fri, 30 Jun 2006 00:41:00 -0400 (EDT)
From: Parag Warudkar <kernel-stuff@comcast.net>
X-X-Sender: paragw@localhost.localdomain
To: v4l-dvb-maintainer@linuxtv.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DVB Needs I2C Core
Message-ID: <Pine.LNX.4.64.0606300037010.9361@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-811323636-1151642460=:9361"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-811323636-1151642460=:9361
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

DVB seems to be using i2c ( i2c_transfer() mainly ) all over the place but 
it is possible to build DVB without having I2C selected. This results in 
undefined symbol i2c_transfer in DVB module.

This patch makes I2C Core selected automatically if DVB is selected.
Is it the right thing to do?

Thanks
Parag
--8323328-811323636-1151642460=:9361
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0606300041000.9361@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=patch

LS0tIGxpbnV4LTIuNi4xNy9kcml2ZXJzL21lZGlhL2R2Yi9LY29uZmlnLm9y
aWcJMjAwNi0wNi0zMCAwMDoxNToxMy4wMDAwMDAwMDAgLTA0MDANCisrKyBs
aW51eC0yLjYuMTcvZHJpdmVycy9tZWRpYS9kdmIvS2NvbmZpZwkyMDA2LTA2
LTMwIDAwOjEwOjE1LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTcsNiArNyw3IEBA
IG1lbnUgIkRpZ2l0YWwgVmlkZW8gQnJvYWRjYXN0aW5nIERldmljZXMNCiBj
b25maWcgRFZCDQogCWJvb2wgIkRWQiBGb3IgTGludXgiDQogCWRlcGVuZHMg
b24gTkVUICYmIElORVQNCisJc2VsZWN0IEkyQw0KIAktLS1oZWxwLS0tDQog
CSAgU3VwcG9ydCBEaWdpdGFsIFZpZGVvIEJyb2FkY2FzdGluZyBoYXJkd2Fy
ZS4gIEVuYWJsZSB0aGlzIGlmIHlvdQ0KIAkgIG93biBhIERWQiBhZGFwdGVy
IGFuZCB3YW50IHRvIHVzZSBpdCBvciBpZiB5b3UgY29tcGlsZSBMaW51eCBm
b3INCg==

--8323328-811323636-1151642460=:9361--
