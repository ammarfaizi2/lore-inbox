Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVFTTK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVFTTK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVFTTJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:09:20 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:56176 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261487AbVFTTDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:03:00 -0400
X-ME-UUID: 20050620190259802.C3F6F1C001D2@mwinf0204.wanadoo.fr
Subject: 2.6.11 amd64: raw1394 returns EINVAL
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 21:02:51 +0200
Message-Id: <1119294171.7213.3.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when using dvgrab (32bits userspace) on an amd64, the 1st write()
syscall on /dev/raw1394 fails with -EINVAL on a 64bits kernel, whereas
it works on a 32bits kernel.

HTH,
	Xav


