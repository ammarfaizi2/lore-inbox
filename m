Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267757AbUHPRDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbUHPRDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUHPRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:03:33 -0400
Received: from the-village.bc.nu ([81.2.110.252]:485 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267799AbUHPRDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:03:20 -0400
Subject: Re: growisofs stopped working with 2.6.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Tony A. Lambley" <tal@vextech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
In-Reply-To: <1092674287.3021.19.camel@bony>
References: <1092674287.3021.19.camel@bony>
Content-Type: multipart/mixed; boundary="=-/EGprgmmfR379dvl8ul/"
Message-Id: <1092672062.20838.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 17:01:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/EGprgmmfR379dvl8ul/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Llu, 2004-08-16 at 17:38, Tony A. Lambley wrote:
> Hi, burning a dvd iso now fails :(
> 
> $ growisofs -Z /dev/hdc=file.iso
> :-( unable to GET CONFIGURATION: Operation not permitted
> :-( non-MMC unit?

We fixed some security holes. In doing so we tightened up so a few apps
that worked before no longer work except as root. Thanks for the error
message. Thats helpful as it suggests the following patch.

(and does it help K3B ?)






--=-/EGprgmmfR379dvl8ul/
Content-Disposition: inline; filename=a1
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=a1; charset=UTF-8

LS0tIGRyaXZlcnMvYmxvY2svc2NzaV9pb2N0bC5jfgkyMDA0LTA4LTE2IDE4OjAxOjM2LjYyNzMw
MTYyNCArMDEwMA0KKysrIGRyaXZlcnMvYmxvY2svc2NzaV9pb2N0bC5jCTIwMDQtMDgtMTYgMTg6
MDE6MzYuNjI3MzAxNjI0ICswMTAwDQpAQCAtMTQ2LDYgKzE0Niw3IEBADQogCQlzYWZlX2Zvcl9y
ZWFkKEdQQ01EX1JFQURfVE9DX1BNQV9BVElQKSwNCiAJCXNhZmVfZm9yX3JlYWQoR1BDTURfUkVQ
T1JUX0tFWSksDQogCQlzYWZlX2Zvcl9yZWFkKEdQQ01EX1NDQU4pLA0KKwkJc2FmZV9mb3JfcmVh
ZChHUENNRF9HRVRfQ09ORklHVVJBVElPTiksDQogDQogCQkvKiBCYXNpYyB3cml0aW5nIGNvbW1h
bmRzICovDQogCQlzYWZlX2Zvcl93cml0ZShXUklURV82KSwNCg==

--=-/EGprgmmfR379dvl8ul/--
