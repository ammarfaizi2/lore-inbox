Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268352AbTAMWBZ>; Mon, 13 Jan 2003 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268366AbTAMWBZ>; Mon, 13 Jan 2003 17:01:25 -0500
Received: from h-64-105-35-9.SNVACAID.covad.net ([64.105.35.9]:54160 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268352AbTAMWBX>; Mon, 13 Jan 2003 17:01:23 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 13 Jan 2003 14:09:49 -0800
Message-Id: <200301132209.OAA02162@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: 2.5.57 missing isapnp_card_protocol
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linux-2.5.57 deletes the definition of isapnp_card_protocol
and then adds some references to it.  So, the kernel does not link
if you have enabled ISA PnP support.  I'm not sure whether
isapnp_card_protocol is supposed to be removed or not.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
