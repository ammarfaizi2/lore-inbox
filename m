Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWCDQnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWCDQnT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWCDQnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:43:19 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:41803 "EHLO
	linux") by vger.kernel.org with ESMTP id S932127AbWCDQnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:43:18 -0500
Message-Id: <20060304164247.963655000@towertech.it>
User-Agent: quilt/0.43-1
Date: Sat, 04 Mar 2006 17:42:47 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 RTC subsystem. 

 Original RFC available at http://lkml.org/lkml/2005/12/20/220

 Changelog. Between parentheses is the name
 of the person that suggested the change.

 - moved generic functions to rtc-lib.c, compiled
 only if CONFIG_RTC_LIB. Any code that relies on those
 functions must "select" that symbol. (Andrew Morton)

 - Fixed a bug in set_mmss (Richard Knutsson, Benoit Boissinot)

 - Added entries to CREDITS and MAINTAINERS

 The following patches have been incorporated:

 - mips-fixed-collision-of-rtc-function-name.patch
   Fix the collision of rtc function name (Yoichi Yuasa)

 - drivers-rtc-make-some-structs-static.patch
   drivers/rtc/: make some structs static (Adrian Bunk)


 The following items are in the TODO:

 - Documentation of exported functions
 - Handling of max_user_freq
 - 11 min ntp update mode

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

--
