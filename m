Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTBLK7g>; Wed, 12 Feb 2003 05:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTBLK6a>; Wed, 12 Feb 2003 05:58:30 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:47497 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267070AbTBLK5c>;
	Wed, 12 Feb 2003 05:57:32 -0500
Date: Wed, 12 Feb 2003 12:07:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Add two new serio type #defines [13/14]
Message-ID: <20030212120710.L1563@ucw.cz>
References: <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz> <20030212120454.H1563@ucw.cz> <20030212120530.I1563@ucw.cz> <20030212120605.J1563@ucw.cz> <20030212120638.K1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120638.K1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:06:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1016, 2003-02-12 11:08:24+01:00, vojtech@suse.cz
  input: Add two new serio type #defines


 serio.h |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Wed Feb 12 11:56:27 2003
+++ b/include/linux/serio.h	Wed Feb 12 11:56:27 2003
@@ -127,6 +127,8 @@
 #define SERIO_TWIDKBD	0x23
 #define SERIO_TWIDJOY	0x24
 #define SERIO_HIL	0x25
+#define SERIO_SNES232	0x26
+#define SERIO_SEMTECH	0x27
 
 #define SERIO_ID	0xff00UL
 #define SERIO_EXTRA	0xff0000UL
