Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSJANSX>; Tue, 1 Oct 2002 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJANSW>; Tue, 1 Oct 2002 09:18:22 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:45830 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261611AbSJANSW>; Tue, 1 Oct 2002 09:18:22 -0400
Date: Tue, 1 Oct 2002 14:23:49 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH][RESEND] trivial video/Config.in fix
Message-ID: <20021001132349.GA60575@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fixes "scripts/Configure: missing ]"

Against 2.5.40

regards
john


diff -Naur -X dontdiff linux-linus/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-linus/drivers/video/Config.in	Sun Sep  8 08:56:46 2002
+++ linux/drivers/video/Config.in	Sat Sep 28 22:00:28 2002
@@ -254,7 +254,7 @@
 	 define_tristate CONFIG_FBCON_CFB2 y
 	 define_tristate CONFIG_FBCON_CFB4 y
       else
-	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_SA1100" = "m"]; then 
+	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_SA1100" = "m" ]; then 
 	    define_tristate CONFIG_FBCON_CFB2 m
 	    define_tristate CONFIG_FBCON_CFB4 m
 	 fi
