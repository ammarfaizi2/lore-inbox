Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSEVIDU>; Wed, 22 May 2002 04:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316888AbSEVIDT>; Wed, 22 May 2002 04:03:19 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:731 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S316887AbSEVIDS>; Wed, 22 May 2002 04:03:18 -0400
Date: Wed, 22 May 2002 10:03:05 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] xconfig for tulip subsection
Message-ID: <20020522080305.GC1402@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixes broken xconfig for tulip drivers.

P.S. Why the double quotes in comment break it?

--- a/v2.5/drivers/net/tulip/Config.in	Wed May 22 09:57:08 2002
+++ b/v2.5/drivers/net/tulip/Config.in	Wed May 22 09:41:31 2002
@@ -3,7 +3,7 @@
 #
 
 mainmenu_option next_comment
-comment '"Tulip" family network device support'
+comment 'Tulip family network device support'
 
 bool '"Tulip" family network device support' CONFIG_NET_TULIP
 if [ "$CONFIG_NET_TULIP" = "y" ]; then

