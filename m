Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbTGTRJX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGTRJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 13:09:23 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12563 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S267557AbTGTRJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 13:09:20 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][devfsd] autodetect 2.4/2.6  kernel version
Date: Sun, 20 Jul 2003 21:23:11 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_//sG/h+SxVF+l4X"
Message-Id: <200307202123.11242.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_//sG/h+SxVF+l4X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As many people seems to have problems with using devfs under 2.6, here is the 
patch I'm using and that goes in current mandrake. It autodetects kernel 
version and is using either /etc/modules.devfs or /etc/modprobe.devfs on 2/4 
and 2/6 resp.

patch is trivial enough and eliminates need for modprobe hack in 
module-init-tools that never worked reliably.

you still have to provide valid modprobe.devfs of course. One in 
module-init-tools has problems but would do as starting point depending on 
which modules you are actually using.

-andrey
--Boundary-00=_//sG/h+SxVF+l4X
Content-Type: application/x-bzip2;
  name="devfsd-1.3.25-kernel-2.5.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="devfsd-1.3.25-kernel-2.5.patch.bz2"

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
OTt8O60P+LuSKcKEgLr2D1A=

--Boundary-00=_//sG/h+SxVF+l4X--

