Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWBZXOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBZXOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWBZXOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:14:49 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:28453 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751425AbWBZXOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:14:49 -0500
Message-Id: <20060226231438.307751000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 27 Feb 2006 00:14:38 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 RTC subsystem. 

 Original RFC available at http://lkml.org/lkml/2005/12/20/220

 Changelog. Between parentheses is the name
 of the person that suggested the change.

 - moved generic functions to lib/rtc.c (Adrian Bunk)

 - upgraded to EXPORT_SYMBOL_GPL where appropriate (Greg KH)

 - misc style fixes (Andrew Morton)

 - moved rtc dev interface to its own class
   and removed kobject events trick (Greg KH)

 - avoid compiling failures if the series
   is partially applied (Andrew Morton)

 The following patches have been incorporated:

 - mips-fixed-collision-of-rtc-function-name.patch
   Fix the collision of rtc function name (Yoichi Yuasa)

 - drivers-rtc-make-some-structs-static.patch
   drivers/rtc/: make some structs static (Adrian Bunk)


 The following items are in the TODO:

 - Documentation of exported functions
 - Handling of max_user_freq
 - 11 min ntp update mode
 - fix a bug in set_mmss (Richard Knutsson)

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
