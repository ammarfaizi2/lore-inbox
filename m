Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTIDGs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbTIDGs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:48:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:40579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264750AbTIDGsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:48:55 -0400
From: John Cherry <cherry@osdl.org>
Message-ID: <13539.4.5.59.77.1062658134.squirrel@www.osdl.org>
Date: Wed, 3 Sep 2003 23:48:54 -0700 (PDT)
Subject: IA32 - 4 New warnings
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the nightly IA32 compiles, I am now flagging NEW warnings that were
introduced into the build in the last 24 hours.  I'll send these out
automatically for awhile with the builds as it has some value at this
stage.

drivers/net/wan/cosa.c:516: warning: implicit declaration of function `sti'
drivers/net/wan/cosa.c:661: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:482)
drivers/net/wan/cosa.c:669: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)
drivers/net/wan/cosa.c:729: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:494)

John


