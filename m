Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSLJQMU>; Tue, 10 Dec 2002 11:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSLJQMU>; Tue, 10 Dec 2002 11:12:20 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:15624 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S262452AbSLJQMR>;
	Tue, 10 Dec 2002 11:12:17 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.51, FB] missing EXPORT_SYMBOL(fb_blank) in fbmem.c
Message-Id: <E18Lmj7-00011o-00@gswi1164.jochen.org>
From: Jochen Hein <jochen@delphi.lan-ks.de>
Date: Tue, 10 Dec 2002 16:55:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I compiled fbcon and neofb as modules, when loading fbcon I get:

root@gswi1164:~# modprobe fbcon
fbcon: Unknown symbol fb_blank
FATAL: Error inserting fbcon (/lib/modules/2.5.51/kernel/fbcon.ko): Unknown symbol in module

Jochen
