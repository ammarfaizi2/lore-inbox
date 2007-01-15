Return-Path: <linux-kernel-owner+w=401wt.eu-S1751259AbXAOReb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbXAOReb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXAOReb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:34:31 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:37074 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXAORea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:34:30 -0500
Date: Mon, 15 Jan 2007 18:34:32 +0100
From: Simon Budig <simon@budig.de>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 2.6.20-rc5] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115173432.GB4582@budig.de>
References: <20070114231135.GA29966@budig.de> <20070115162847.GB3751@budig.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115162847.GB3751@budig.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Budig <simon@budig.de>

This trivial change adds some missing enum values to the hid-debug output.

Signed-off-by: Simon Budig <simon@budig.de>


--- linux/include/linux/hid-debug.h.orig	2007-01-15 18:19:52.000000000 +0100
+++ linux/include/linux/hid-debug.h	2007-01-15 18:21:44.000000000 +0100
@@ -700,9 +700,10 @@ static char *keys[KEY_MAX + 1] = {
 
 static char *relatives[REL_MAX + 1] = {
 	[REL_X] = "X",			[REL_Y] = "Y",
-	[REL_Z] = "Z",			[REL_HWHEEL] = "HWheel",
-	[REL_DIAL] = "Dial",		[REL_WHEEL] = "Wheel",
-	[REL_MISC] = "Misc",
+	[REL_Z] = "Z",			[REL_RX] = "Rx",
+	[REL_RY] = "Ry",		[REL_RZ] = "Rz",
+	[REL_HWHEEL] = "HWheel",	[REL_DIAL] = "Dial",
+	[REL_WHEEL] = "Wheel",		[REL_MISC] = "Misc",
 };
 
 static char *absolutes[ABS_MAX + 1] = {
