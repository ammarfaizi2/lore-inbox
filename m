Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269655AbUICMVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbUICMVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUICMRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:17:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:44530 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269659AbUICMPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:15:20 -0400
Date: Fri, 3 Sep 2004 15:14:36 +0300
From: "Tigran S. Avanesov" <tigra@kermo.cubetex.net>
X-Mailer: The Bat! (v2.04.7)         CD5BF9353B3B7091
Reply-To: "Tigran S. Avanesov" <tigra@kermo.cubetex.net>
X-Priority: 3 (Normal)
Message-ID: <975351303.20040903151436@kermo.cubetex.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: inconsistency between Makefile and kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Mandrake linux kernel linux-2.6.3-4mdk.
/drivers/input/joystick
kconfig contains:
config JOYSTICK_TWIDDLER
Makefile contains
obj-$(CONFIG_JOYSTICK_TWIDJOY)          += twidjoy.o

where twiddler!=twidjoy

-- 
Best regards,
 Tigran                          mailto:tigra@kermo.cubetex.net

