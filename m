Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVAKXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVAKXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVAKXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:43:10 -0500
Received: from coderock.org ([193.77.147.115]:13510 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262950AbVAKXfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:31 -0500
Subject: [patch 11/11] pss.c - vfree() checking cleanups
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:23 +0100
Message-Id: <20050111233524.3A82E1F228@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pss.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/pss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN sound/oss/pss.c~vfree-sound_oss_pss sound/oss/pss.c
--- kj/sound/oss/pss.c~vfree-sound_oss_pss	2005-01-10 18:01:08.000000000 +0100
+++ kj-domen/sound/oss/pss.c	2005-01-10 18:01:08.000000000 +0100
@@ -1242,7 +1242,7 @@ static void __exit cleanup_pss(void)
 {
 	if(!pss_no_sound)
 	{
-		if(fw_load && pss_synth)
+		if(fw_load)
 			vfree(pss_synth);
 		if(pssmss)
 			unload_pss_mss(&cfg2);
_
