Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbTGJQy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbTGJQy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:54:27 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:15112 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S269281AbTGJQy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:54:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10578569453113@movementarian.org>
Subject: [PATCH 3/3] OProfile: fix a comment
In-Reply-To: <10578569441778@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 10 Jul 2003 18:09:05 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19aeuo-000Aib-5W*OGhzyAIlQBU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reflect Intel manual bugfix, by Philippe Elie

diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/op_model_p4.c linux-fixes/arch/i386/oprofile/op_model_p4.c
--- linux-cvs/arch/i386/oprofile/op_model_p4.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-fixes/arch/i386/oprofile/op_model_p4.c	2003-07-10 18:22:51.000000000 +0100
@@ -278,7 +278,7 @@
 	},
 
 	{ /* GLOBAL_POWER_EVENTS */
-		0x06, 0x13 /* manual says 0x05 */, 
+		0x06, 0x13 /* older manual says 0x05, newer 0x13 */,
 		{ { CTR_BPU_0, MSR_P4_FSB_ESCR0},
 		  { CTR_BPU_2, MSR_P4_FSB_ESCR1} }
 	},

