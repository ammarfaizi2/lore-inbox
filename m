Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKQS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKQS7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVKQS7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:59:14 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:9932 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932462AbVKQS7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:59:13 -0500
Date: Thu, 17 Nov 2005 19:58:58 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Subject: [RFC] kernel RTC infrastructure
Message-ID: <20051117195858.61079ed0@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

   I'd like to ask a few questions about the kernel RTC infrastructure.

 Actually, it seems that each different RTC driver is working on is own:

 drivers/char/ds1286.c
 drivers/char/genrtc.c
 drivers/char/ip27-rtc.c
 drivers/char/rtc.c
 drivers/input/misc/hp_sdc_rtc.c
 
 are all self-contained RTC drivers.

 The situation is a slightly better on ARM, where
 arch/arm/common/rtctime.c
 contains common RTC registration code (register_rtc(...)).

 Has an interface like the ARM one been pondered for the whole
 kernel?

 Could it be used as the standard kernel RTC interface?
 
 Thanks!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

