Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRCWCoE>; Thu, 22 Mar 2001 21:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCWCny>; Thu, 22 Mar 2001 21:43:54 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:53915 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129084AbRCWCnv>; Thu, 22 Mar 2001 21:43:51 -0500
Date: Thu, 22 Mar 2001 21:42:55 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Some strange patch to drivers/input/keybdev.c
Message-ID: <20010322214255.A4737@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some guy sent me the attached patch. He says it allows
him to use 2 additional keys on the 106 key USB keyboard.
I never saw a 106 key keyboard before, USB or not.
Does anyone understand what is going on? Vojtech?

-- Pete

--- drivers/input/keybdev.c.orig      Sat Sep  2 19:01:55 2000
+++ drivers/input/keybdev.c   Sat Sep  2 20:21:07 2000
@@ -49,11 +49,11 @@
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
 	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
 	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,294,293,286,350, 92,334,512,116,377,109,111,373,347,348,349,
+	367,294,293,286,350, 92,334,512,116,377,109,111,115,347,348,349,
 	360, 93, 94, 95, 98,376,100,101,357,316,354,304,289,102,351,355,
 	103,104,105,275,281,272,306,106,274,107,288,364,358,363,362,361,
 	291,108,381,290,287,292,279,305,280, 99,112,257,258,113,270,114,
-	118,117,125,374,379,259,260,261,262,263,264,265,266,267,268,269,
+	118,117,125,374,125,259,260,261,262,263,264,265,266,267,268,269,
 	271,273,276,277,278,282,283,295,296,297,299,300,301,302,303,307,
 	308,310,313,314,315,317,318,319,320,321,322,323,324,325,326,330,
 	332,340,341,342,343,344,345,346,356,359,365,368,369,370,371,372 };
