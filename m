Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWBENkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWBENkp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWBENkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:40:45 -0500
Received: from math.ut.ee ([193.40.36.2]:60909 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750812AbWBENkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:40:45 -0500
Date: Sun, 5 Feb 2006 15:40:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH] Add logitech mouse type 99
Message-ID: <Pine.SOC.4.61.0602051459260.17326@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Logitech mouse type 99 (Premium Optical Wheel Mouse, model M-BT58, 
plain 3 buttons + wheel) to cure the following message:
logips2pp: Detected unknown logitech mouse model 99

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index c88520d..40333d6 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -232,6 +232,7 @@ static struct ps2pp_info *get_model_info
  		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
  		{ 96,	0,			0 },
  		{ 97,	PS2PP_KIND_TP3,		PS2PP_WHEEL | PS2PP_HWHEEL },
+		{ 99,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
  		{ 100,	PS2PP_KIND_MX,					/* MX510 */
  				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
  				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },

-- 
Meelis Roos (mroos@linux.ee)
