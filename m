Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVD1A5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVD1A5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVD1A5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:57:50 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:8689 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262125AbVD1A5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:57:49 -0400
From: ndnguyen3@comcast.net
To: linux-kernel@vger.kernel.org
Cc: ndnguyen3@comcast.net
Subject: oops data from direct memory dump of log_buf?
Date: Thu, 28 Apr 2005 00:57:47 +0000
Message-Id: <042820050057.1269.4270350B00034F22000004F52206998499CC020A979A09020B02@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: bmRuZ3V5ZW4zQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am sorry if this question is too simple or to the wrong list. In kernel 2.4.x whenever there is a kernel crash, I was able to find Oops data from a direct memory dump starting starting from log_buf. With kernel 2.6.x, I can not find the Oops data from the same memory dump. Do I need to look into different place for the Oops info for 2.6.x? Many thanks.

Best regards,

Nguyen

Ps: Most of the time I can use Dmesg to look for Oops info. However there are numerous times where crashes occur too "early" in the boot process. Hence I need to look at log_buf (via memory dump) to see the Oops or to read prink messages to see how far the boot process got.
