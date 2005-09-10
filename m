Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVIJWdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVIJWdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVIJWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:33:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:15780 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932344AbVIJWdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:49 -0400
Subject: [PATCH 4/26] psmouse - add new Logitech wheel mouse model
In-Reply-To: <11263916512254@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:11 +0200
Message-Id: <11263916511448@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: psmouse - add new Logitech wheel mouse model
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125816055 -0500

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/mouse/logips2pp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

d2b5ffca73594e4046f405e3ef2438ce41f76fb2
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -223,6 +223,7 @@ static struct ps2pp_info *get_model_info
 		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
 		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
+		{ 86,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 96,	0,			0 },
 		{ 97,	PS2PP_KIND_TP3,		PS2PP_WHEEL | PS2PP_HWHEEL },

