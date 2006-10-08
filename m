Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWJHOBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWJHOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWJHOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:01:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14469 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751184AbWJHOBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:01:15 -0400
Date: Sun, 8 Oct 2006 15:01:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in pdaudiocf_irq
Message-ID: <20061008140114.GV29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c b/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
index 732263e..5bd6920 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
@@ -22,6 +22,7 @@ #include <sound/driver.h>
 #include <sound/core.h>
 #include "pdaudiocf.h"
 #include <sound/initval.h>
+#include <asm/irq_regs.h>
 
 /*
  *
-- 
1.4.2.GIT

