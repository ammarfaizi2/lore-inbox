Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319324AbSHVLhk>; Thu, 22 Aug 2002 07:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319325AbSHVLhk>; Thu, 22 Aug 2002 07:37:40 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:34219 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S319324AbSHVLhj>; Thu, 22 Aug 2002 07:37:39 -0400
Date: Thu, 22 Aug 2002 13:41:28 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: trivial: 2.5.31+bk forgotten endmenu
Message-ID: <20020822114128.GA7095@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the forgotten endmenu statement broke xconfig.


--- v2.5.31+bk/drivers/net/appletalk/Config.in	2002-08-13 06:05:49.000000000 +0200
+++ v2.5.31+bk/drivers/net/appletalk/Config.in	2002-08-22 13:33:17.000000000 +0200
@@ -17,3 +17,4 @@
       bool '    Appletalk-IP to IP Decapsulation support' CONFIG_IPDDP_DECAP
    fi
 fi
+endmenu
