Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVG3AWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVG3AWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVG2TTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:63406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262651AbVG2TQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:22 -0400
Date: Fri, 29 Jul 2005 12:15:38 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru
Subject: [patch 12/29] w1: kconfig/Makefile fix.
Message-ID: <20050729191538.GN5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

This patch was sent first time very long time ago, 
but magically was disapeared, it probably exists
in your queue, but to be sure, I resend it.
If can not be applied cleanly after your w1 queue is flushed
into upstrem tree, just drop it.
Thanks.

Patch from Michael Farmbauer <michl@baldrian.franken.de>.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/w1/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/w1/Kconfig	2005-07-29 11:29:58.000000000 -0700
+++ gregkh-2.6/drivers/w1/Kconfig	2005-07-29 11:36:20.000000000 -0700
@@ -30,7 +30,7 @@
 	  This support is also available as a module.  If so, the module
 	  will be called ds9490r.ko.
 
-config W1_DS9490R_BRIDGE
+config W1_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help

--
