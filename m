Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbUCNMke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbUCNMkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:40:32 -0500
Received: from av5-1-sn1.fre.skanova.net ([81.228.11.111]:10477 "EHLO
	av5-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263352AbUCNMka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:40:30 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.6.4-1
References: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Mar 2004 13:40:26 +0100
In-Reply-To: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
Message-ID: <m2brmz1u11.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> This patch updates UML to 2.6.4.  Besides the update, there were the following
> changes since the last patch:
> 	a bug which caused either a crash in the kernel or a BUG at exit.c:793
> was fixed
> 	a bug which caused a crash when a process tried to dump core was fixed
> 	the hang early in boot on GHz hosts is gone
> 	various other
> 
> The 2.6.4-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.4-1.bz2

+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */


I think it's cleaner to handle this in your .emacs file. Here is what
I use:

(add-to-list 'auto-mode-alist '("/home/petero/kernel.*/.*\\.[ch]$" . linux-c-mode))

(defun linux-c-mode ()
  "C mode with adjusted defaults for the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

This way it will work for all kernel files, not just the ones
containing special emacs comments.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
