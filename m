Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSFDIoz>; Tue, 4 Jun 2002 04:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSFDIoy>; Tue, 4 Jun 2002 04:44:54 -0400
Received: from boden.synopsys.com ([204.176.20.19]:10693 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S316572AbSFDIox>; Tue, 4 Jun 2002 04:44:53 -0400
Date: Tue, 4 Jun 2002 10:44:31 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH 2.5.20] typo in quotas config
Message-ID: <20020604084431.GA29455@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The entry for quota with 32bit UID/GID support is named "VFS v0...".

--- Config.in   Tue Jun  4 10:21:46 2002
+++ Config.in.new       Tue Jun  4 10:41:56 2002
@@ -6,7 +6,7 @@
 
 bool 'Quota support' CONFIG_QUOTA
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
-dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
+dep_tristate '  Quota format v2 support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 if [ "$CONFIG_QUOTA" = "y" ]; then
    define_bool CONFIG_QUOTACTL y
 fi

