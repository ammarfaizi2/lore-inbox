Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUFFV5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUFFV5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUFFV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 17:57:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:3276 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264175AbUFFV53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 17:57:29 -0400
Date: Sun, 6 Jun 2004 22:56:53 +0100
From: Dave Jones <davej@redhat.com>
To: John Cherry <cherry@osdl.org>, Paul Fulghum <paulkf@microgate.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.7-rc2 - 2004-06-05.22.30) - 1 New warnings (gcc 3.2.2)
Message-ID: <20040606215653.GA7907@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Cherry <cherry@osdl.org>, Paul Fulghum <paulkf@microgate.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200406061823.i56INbCg028820@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406061823.i56INbCg028820@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 11:23:37AM -0700, John Cherry wrote:
 > drivers/char/synclink.c:4559: warning: control reaches end of non-void function
 
Signed-off-by: Dave Jones <davej@redhat.com>
 
		Dave


--- bk-linus/drivers/char/synclink.c~	2004-06-06 22:55:06.568867456 +0100
+++ bk-linus/drivers/char/synclink.c	2004-06-06 22:55:16.420369800 +0100
@@ -4525,7 +4525,7 @@
 
 /* enumerate user specified ISA adapters
  */
-static int mgsl_enum_isa_devices(void)
+static void mgsl_enum_isa_devices(void)
 {
 	struct mgsl_struct *info;
 	int i;
