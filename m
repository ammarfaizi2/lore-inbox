Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUAUAnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUAUAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:43:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8670 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265841AbUAUAnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:43:50 -0500
Date: Wed, 21 Jan 2004 01:43:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: mpt_linux_developer@lsil.com, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [2.6 patch] remove obsolete comment from fusion Kconfig
Message-ID: <20040121004345.GK6441@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes obsolete comments from the fusion Kconfig file 
that were left after the conversion to the new config system.

Please apply
Adrian

--- linux-2.6.1-mm5/drivers/message/fusion/Kconfig.old	2004-01-21 01:40:34.000000000 +0100
+++ linux-2.6.1-mm5/drivers/message/fusion/Kconfig	2004-01-21 01:40:44.000000000 +0100
@@ -138,11 +138,5 @@
 	  Support for building this feature into the linux kernel is not
 	  yet available.
 
-#  if [ "$CONFIG_FUSION_LAN" != "n" ]; then
-#    define_bool CONFIG_NET_FC y
-#  fi
-# These <should> be define_tristate, but we leave them define_bool
-# for backward compatibility with pre-linux-2.2.15 kernels.
-# (Bugzilla:fibrebugs, #384)
 endmenu
 
