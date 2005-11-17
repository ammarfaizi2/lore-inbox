Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVKQRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVKQRcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVKQRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:32:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:47764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932432AbVKQRcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:32:13 -0500
Date: Thu, 17 Nov 2005 09:10:47 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: build error in current -git tree
Message-ID: <20051117171047.GA27534@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to build your kernel tree right now, I get the following
error:

  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/signal.h:6,
                 from include/linux/sched.h:28,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/signal.h:190: error: redefinition of '__const_sigaddset'
include/asm/signal.h:173: error: previous definition of '__const_sigaddset' was here
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2


thanks,

greg k-h
