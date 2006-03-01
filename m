Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCAUQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCAUQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWCAUQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:16:43 -0500
Received: from mx02.qsc.de ([213.148.130.14]:60103 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1750710AbWCAUQn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:16:43 -0500
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org
Subject: MAX_USBFS_BUFFER_SIZE
Date: Wed, 1 Mar 2006 21:16:25 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603012116.25869.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, I wonder if: drivers/usb/core/devio.c:86 #define
	MAX_USBFS_BUFFER_SIZE 16384 [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder if:

drivers/usb/core/devio.c:86
#define MAX_USBFS_BUFFER_SIZE   16384

is some random, or outdated limit or if there really is some code path that could
not handle bigger URBs.

For performance reasons I would like to use bigger packages for an image
aquisition device.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
