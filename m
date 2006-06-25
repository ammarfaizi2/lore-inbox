Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWFYPnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWFYPnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWFYPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:43:08 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:7887 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S1751444AbWFYPnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:43:07 -0400
Message-ID: <449EAE70.3010000@free-electrons.com>
Date: Sun, 25 Jun 2006 17:40:32 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH][TRIVIAL] Compile fix for the rtc test program
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a trivial compile fix the test program embedded in 
Documentation/rtc.txt
Without it, compiling issues many ugly warnings:
warning: incompatible implicit declaration of built-in function ‘exit’

Also available on 
http://free-electrons.com/pub/patches/linux/20060625/rtc-test.patch

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

--- linux-2.6.17/Documentation/rtc.txt 2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17-rtc-test/Documentation/rtc.txt 2006-06-25 
16:49:26.000000000 +0200
@@ -81,6 +81,7 @@ that will be using this driver.
*/

#include <stdio.h>
+#include <stdlib.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <sys/time.h>

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)


