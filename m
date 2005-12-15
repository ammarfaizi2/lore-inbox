Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbVLOFqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbVLOFqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbVLOFp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:45:58 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:16517 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161131AbVLOFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:45:56 -0500
Message-Id: <20051215053933.125918000.dtor_core@ameritech.net>
Date: Thu, 15 Dec 2005 00:39:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: [patch 0/3] wbsd: convert to the new platfrom device interface and more
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch converts wbsd driver to the new platfrom device
interface. platfrom_device_register_simple() is going away, we need
to platfrom_device_alloc() + platfrom_device_add() instead.

The second patch is a result of passing the driver through Lindent
so it conforms to the kernel conding style. Feel free to drop it if
you don't like what you see.

The third patch converts the driver to use ARRAY_SIZE() macro instead
of open-coding it.

The patches were compile-tested on i386, I do not have the hardware
to verify it it still runs.

--
Dmitry

