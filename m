Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVGJWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVGJWyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVGJThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:27539 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262041AbVGJTg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:29 -0400
Date: Sun, 10 Jul 2005 19:36:29 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 81/82] remove linux/version.h from drivers/usb
Message-ID: <20050710193629.81.MzzoRA4422.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

use linux/utsname.h to get KERNEL_VERSION macro

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/usb/media/sn9c102.h |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/usb/media/sn9c102.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/media/sn9c102.h
+++ linux-2.6.13-rc2-mm1/drivers/usb/media/sn9c102.h
@@ -21,7 +21,7 @@
#ifndef _SN9C102_H_
#define _SN9C102_H_

-#include <linux/version.h>
+#include <linux/utsname.h>
#include <linux/usb.h>
#include <linux/videodev.h>
#include <linux/device.h>
