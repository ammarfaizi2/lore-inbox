Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbVKWXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbVKWXwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbVKWXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:44738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751343AbVKWXqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:42 -0500
Date: Wed, 23 Nov 2005 15:45:58 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       nikai@nikai.net
Subject: [patch 22/22] usb serial: remove redundant include
Message-ID: <20051123234558.GW527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-serial-remove-redundant-include.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Kaiser <nikai@nikai.net>

remove redundant include

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/ipw.c |    1 -
 1 file changed, 1 deletion(-)

--- usb-2.6.orig/drivers/usb/serial/ipw.c
+++ usb-2.6/drivers/usb/serial/ipw.c
@@ -46,7 +46,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
-#include <linux/usb.h>
 #include <asm/uaccess.h>
 #include "usb-serial.h"
 

--
