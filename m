Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRJBMEH>; Tue, 2 Oct 2001 08:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRJBMD6>; Tue, 2 Oct 2001 08:03:58 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:36616 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S272540AbRJBMDu>; Tue, 2 Oct 2001 08:03:50 -0400
Date: Tue, 2 Oct 2001 12:50:40 +0100
From: Alan Ford <alan@whirlnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.11-pre2
Message-ID: <20011002125040.A10878@whirlnet.co.uk>
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com> <200110012218.f91MIGU10233@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110012218.f91MIGU10233@hswn.dk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 12:18:16AM +0200, henrik@hswn.dk wrote:
> Seems this patch to drivers/char/sysrq.c should not be in:

While we're fixing typos in sysrq.c:

--- linux.vanilla/drivers/char/sysrq.c	Tue Oct  2 12:46:39 2001
+++ linux/drivers/char/sysrq.c	Tue Oct  2 12:47:15 2001
@@ -236,7 +236,7 @@
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
 	help_msg:	"Unmount",
-	action_msg:	"Emergency Remount R/0\n",
+	action_msg:	"Emergency Remount R/O\n",
 };
 
 /* END SYNC SYSRQ HANDLERS BLOCK */

-- 
Alan Ford * alan@whirlnet.co.uk 
