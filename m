Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWBXBtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWBXBtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBXBtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:49:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5598 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932506AbWBXBtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:49:49 -0500
Date: Thu, 23 Feb 2006 20:49:47 -0500
From: Dave Jones <davej@redhat.com>
To: dtor_core@ameritech.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: multimedia keys on dell inspiron 8200s.
Message-ID: <20060224014947.GA17397@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, dtor_core@ameritech.net,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been carrying this patch in Fedora for way too long.
So long, I've forgotten a lot of the history.

Aparently, it makes multimedia buttons on Dell Inspiron 8200's
produce keycodes.  The only reference to this I found was
at http://linux.siprell.com/, but I don't know if that's its origin.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/input/keyboard/atkbd.c~	2005-04-16 12:45:00.000000000 -0400
+++ linux-2.6/drivers/input/keyboard/atkbd.c	2005-04-16 12:46:28.000000000 -0400
@@ -90,13 +90,13 @@ static unsigned char atkbd_set2_keycode[
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
-	173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
+	217,100,255,  0, 97,165,196,  0,156,  0,  0,  0,  0,  0,197,125,
+	173,114,  0,113,  0,  0,198,126,128,  0,  0,140,  0,  0,  0,127,
 	159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
 	226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
+	110,111,108,112,106,103,195,119,  0,118,109,  0, 99,104,119,  0,
 
 	  0,  0,  0, 65, 99,
 #endif
