Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbRACLqo>; Wed, 3 Jan 2001 06:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbRACLqe>; Wed, 3 Jan 2001 06:46:34 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:36102 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131101AbRACLqY>;
	Wed, 3 Jan 2001 06:46:24 -0500
Date: Wed, 3 Jan 2001 12:15:10 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jens Nestel <niob@spruce.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: removing the bootlogo
Message-ID: <20010103121510.A7739@vana.vc.cvut.cz>
In-Reply-To: <20010103023351.A9753@spruce.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010103023351.A9753@spruce.yi.org>; from niob@spruce.yi.org on Wed, Jan 03, 2001 at 02:33:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 02:33:52AM +0100, Jens Nestel wrote:
> hi,
> 
> I am using matroxfb with a MGA200 card,
> but I find the bootlogo quite annoying.
> 
> Is there an easy way to remove it ?

You dislike penguins? What about this one? This patch is
for 2.4.0-prerelease with testing/prerelease.diff as of 5 minutes ago. 
I have no idea about official name of this version ;-)
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz


--- linux-2.4.0-prerelease-p/drivers/video/fbcon.c.orig	Sun Oct 29 06:17:34 2000
+++ linux-2.4.0-prerelease-p/drivers/video/fbcon.c	Wed Jan  3 12:11:29 2001
@@ -2056,6 +2056,8 @@
     int i, j, n, x1, y1, x;
     int logo_depth, done = 0;
 
+    return 0;
+
     /* Return if the frame buffer is not mapped */
     if (!fb)
 	return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
