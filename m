Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVCESFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVCESFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVCESFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:05:34 -0500
Received: from 83-70-41-223.b-ras1.prp.dublin.eircom.net ([83.70.41.223]:52865
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261694AbVCESFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:05:20 -0500
Date: Sat, 5 Mar 2005 18:02:27 +0000 (GMT)
From: Telemaque Ndizihiwe <telendiz@eircom.net>
X-X-Sender: telendiz@localhost.localdomain
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Removes unused variable from /sound/usb/usx2y/usbusx2yaudio.c
Message-ID: <Pine.LNX.4.62.0503051720430.792@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This Patch removes unused variable from /sound/usb/usx2y/usbusx2yaudio.c 
in kernel 2.6.11

Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>

--- linux-2.6.11/sound/usb/usx2y/usbusx2yaudio.c.orig	2005-03-05 17:05:20.165551616 +0000
+++ linux-2.6.11/sound/usb/usx2y/usbusx2yaudio.c	2005-03-05 17:09:43.072583672 +0000
@@ -415,7 +415,6 @@ static int usX2Y_urbs_allocate(snd_usX2Y
  	unsigned int pipe;
  	int is_playback = subs == subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
  	struct usb_device *dev = subs->usX2Y->chip.dev;
-	struct usb_host_endpoint *ep;

  	pipe = is_playback ? usb_sndisocpipe(dev, subs->endpoint) :
  			usb_rcvisocpipe(dev, subs->endpoint);
