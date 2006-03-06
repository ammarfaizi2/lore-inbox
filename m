Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWCFB4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWCFB4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWCFBxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:53:14 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:55423 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751582AbWCFBxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:53:13 -0500
Message-Id: <20060306015008.858209000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 06 Mar 2006 02:50:08 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@digeo.com
Subject: [PATCH 00/16] RTC subsystem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 RTC subsystem. 

 Original RFC available at http://lkml.org/lkml/2005/12/20/220

 Changelog. Between parentheses is the name
 of the person that suggested the change.

 - Changed the Makefile to be dependent on
 CONFIG_RTC_LIB (Adrian Bunk)

 - Added RTC driver for the EP93XX

 - CONFIG_RTC_CLASS defaults to n (Grant Coady)

 The following patches have been incorporated:

 - Fix some namespace conflicts between the RTC subsystem and the ARM
   Integrator time functions (Richard Purdie)

 - ARM SA1100/PXA2XX driver. (Richard Purdie)

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
