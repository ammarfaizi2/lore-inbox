Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTAIVKa>; Thu, 9 Jan 2003 16:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTAIVKa>; Thu, 9 Jan 2003 16:10:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267888AbTAIVKa>;
	Thu, 9 Jan 2003 16:10:30 -0500
Subject: Can't build sound drivers as modules (2.5.55)
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1042147153.4870.66.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 13:19:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to install with sound as a configured module:

WARNING: /lib/modules/2.5.55/kernel/sound/soundcore.ko needs unknown
symbol
 errno

This is new in 2.5.55, not sure where the missing bogus definition is.
It looks like soundcore.ko contains sound_firmware.o which is seems to
be more of an application than a driver (open/close)...


-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab



