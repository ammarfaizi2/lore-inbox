Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262333AbSI1U77>; Sat, 28 Sep 2002 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbSI1U77>; Sat, 28 Sep 2002 16:59:59 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:25354 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262333AbSI1U76>; Sat, 28 Sep 2002 16:59:58 -0400
Date: Sat, 28 Sep 2002 22:05:13 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] drivers/video/Config.in missing space
Message-ID: <20020928210513.GA60754@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vOm1-000O5o-00*w9E5Ad2xUXo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Against 2.5.39

regards
john


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
