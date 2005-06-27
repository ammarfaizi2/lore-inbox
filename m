Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVF0Nbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVF0Nbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVF0NbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:31:05 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:22757 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262072AbVF0MQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:48 -0400
Message-Id: <20050627121419.634867000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:50 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Michael Paxton <packo@tpg.com.au>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-twinhan-vp7045-rc2.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 50/51] usb: vp7045 IR map fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Paxton <packo@tpg.com.au>

Correct two keys of the vp7045 remote control key mapping.

Signed-off-by: Michael Paxton <packo@tpg.com.au>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/vp7045.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/vp7045.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-06-27 13:27:07.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/vp7045.c	2005-06-27 13:27:09.000000000 +0200
@@ -120,9 +120,9 @@ static struct dvb_usb_rc_key vp7045_rc_k
 	{ 0x00, 0x4c, KEY_PAUSE },
 	{ 0x00, 0x4d, KEY_SCREEN }, /* Full screen mode. */
 	{ 0x00, 0x54, KEY_AUDIO }, /* MTS - Switch to secondary audio. */
-	{ 0x00, 0xa1, KEY_CANCEL }, /* Cancel */
+	{ 0x00, 0x0c, KEY_CANCEL }, /* Cancel */
 	{ 0x00, 0x1c, KEY_EPG }, /* EPG */
-	{ 0x00, 0x40, KEY_TAB }, /* Tab */
+	{ 0x00, 0x00, KEY_TAB }, /* Tab */
 	{ 0x00, 0x48, KEY_INFO }, /* Preview */
 	{ 0x00, 0x04, KEY_LIST }, /* RecordList */
 	{ 0x00, 0x0f, KEY_TEXT } /* Teletext */

--

