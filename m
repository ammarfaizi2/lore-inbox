Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313856AbSDJVgK>; Wed, 10 Apr 2002 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313860AbSDJVgJ>; Wed, 10 Apr 2002 17:36:09 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:12026 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S313856AbSDJVgI>; Wed, 10 Apr 2002 17:36:08 -0400
Date: Wed, 10 Apr 2002 14:35:58 -0700
From: Chris Wright <chris@wirex.com>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.8-pre3 capability.h comment cleanup
Message-ID: <20020410143558.A2082@figure1.int.wirex.com>
Mail-Followup-To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With recent nfsservctl cleanup, nfsservctl is no longer protected by
CAP_SYS_ADMIN, rather CAP_DAC_OVERRIDE.  This patch against 2.5.8-pre3
simply removes the now invalid comment in capability.h.

thanks,
-chris

--- 1.3/include/linux/capability.h	Fri Feb  8 19:10:55 2002
+++ edited/include/linux/capability.h	Wed Apr 10 14:11:06 2002
@@ -203,7 +203,6 @@
 /* Allow calling bdflush() */
 /* Allow mount() and umount(), setting up new smb connection */
 /* Allow some autofs root ioctls */
-/* Allow nfsservctl */
 /* Allow VM86_REQUEST_IRQ */
 /* Allow to read/write pci config on alpha */
 /* Allow irix_prctl on mips (setstacksize) */
