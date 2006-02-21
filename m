Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161314AbWBUDsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWBUDsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWBUDsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:13 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:63932 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161301AbWBUDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:06 -0500
Message-Id: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:28 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch 0/8] fix build errors by bitops code consolidation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to http://l4x.org/k/ the bitops code consolidation patches break
2.6.16-rc4-mm1 on arm, m68k, ppc, s390, um architectures at least.

These patches fix the problem disclosed by http://l4x.org/k/
and typo fixes.

--
