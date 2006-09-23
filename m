Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWIWHlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWIWHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWIWHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 03:41:09 -0400
Received: from mx3.mail.ru ([194.67.23.149]:27940 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751027AbWIWHlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 03:41:07 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 - vesafb unaiavilable if fbcon compiled as module
Date: Sat, 23 Sep 2006 11:40:49 +0400
User-Agent: KMail/1.9.4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231140.50220.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is it intentional? In Kconfig:

config FB_VESA
        bool "VESA VGA graphics support"
        depends on (FB = y) && X86

Thank you

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFFOUCR6LMutpd94wRAnxCAJ0aOP0G6h12/TGAn5SiOHcVsQRaIACfRm6G
Byy13BTwmiOjjHn6qlrIAps=
=vrNk
-----END PGP SIGNATURE-----
