Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVEaIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVEaIuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEaIuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:50:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58775 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261393AbVEaIuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:50:17 -0400
Date: Tue, 31 May 2005 10:49:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Update video-after-suspend documentation 
Message-ID: <20050531084958.GA4285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update video-after-suspend documentation; few more machines are added.

Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: Documentation/power/video.txt
===================================================================
--- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/Documentation/power/video.txt  (mode:100644)
+++ ecd8559cc08319bb16a42aac06cf7d664157643a/Documentation/power/video.txt  (mode:100644)
@@ -83,8 +83,10 @@
 Compaq Evo N620c		vga=normal, s3_bios (2)
 Dell 600m, ATI R250 Lf		none (1), but needs xorg-x11-6.8.1.902-1
 Dell D600, ATI RV250            vga=normal and X, or try vbestate (6)
+Dell D610			vga=normal and X (possibly vbestate (6) too, but not tested)
 Dell Inspiron 4000		??? (*)
 Dell Inspiron 500m		??? (*)
+Dell Inspiron 510m		???
 Dell Inspiron 600m		??? (*)
 Dell Inspiron 8200		??? (*)
 Dell Inspiron 8500		??? (*)
@@ -123,6 +125,7 @@
 Toshiba Satellite 4080XCDT      s3_mode (3)
 Toshiba Satellite 4090XCDT      ??? (*)
 Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
+Toshiba M30                     (2) xor X with nvidia driver using internal AGP
 Uniwill 244IIO			??? (*)
 
 
