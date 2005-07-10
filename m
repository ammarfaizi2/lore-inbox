Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVGJWyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVGJWyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVGJThs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:17043 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261983AbVGJTgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:09 -0400
Date: Sun, 10 Jul 2005 19:36:09 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 61/82] remove linux/version.h from drivers/video/intelfb/intelfb*
Message-ID: <20050710193609.61.TODvKN3895.2247.olh@nectarine.suse.de>
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

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/video/intelfb/intelfbdrv.c |    1 -
drivers/video/intelfb/intelfbhw.c  |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/video/intelfb/intelfbdrv.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/intelfb/intelfbdrv.c
+++ linux-2.6.13-rc2-mm1/drivers/video/intelfb/intelfbdrv.c
@@ -126,7 +126,6 @@
#include <linux/kd.h>
#include <linux/vt_kern.h>
#include <linux/pagemap.h>
-#include <linux/version.h>

#include <asm/io.h>

Index: linux-2.6.13-rc2-mm1/drivers/video/intelfb/intelfbhw.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/intelfb/intelfbhw.c
+++ linux-2.6.13-rc2-mm1/drivers/video/intelfb/intelfbhw.c
@@ -38,7 +38,6 @@
#include <linux/kd.h>
#include <linux/vt_kern.h>
#include <linux/pagemap.h>
-#include <linux/version.h>

#include <asm/io.h>

