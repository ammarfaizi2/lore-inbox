Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTBKKEU>; Tue, 11 Feb 2003 05:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbTBKKEU>; Tue, 11 Feb 2003 05:04:20 -0500
Received: from h-64-105-35-123.SNVACAID.covad.net ([64.105.35.123]:49283 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267355AbTBKKEU>; Tue, 11 Feb 2003 05:04:20 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 11 Feb 2003 02:13:56 -0800
Message-Id: <200302111013.CAA31789@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.60: .o or .ko for CONFIG_MODVERSIONS?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I just tried to build 2.5.60 with CONFIG_MODVERSIONS.
It tries to build modules with the .o extension instead of .ko,
but "make modules_install" still expects modules to be have a ,ko
extension.

	Building with CONFIG_MODVERSIONS generates modules with a .ko
extension.

	I assume this is a bug in the newly restored
CONFIG_MODVERSIONS option, although I'd be happy to have modules use
the .o extension again.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


