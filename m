Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWHHUsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWHHUsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHHUsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:48:15 -0400
Received: from mail.linicks.net ([217.204.244.146]:18827 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965017AbWHHUsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:48:14 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Still get build warnings - gcc-3.4.6 - 2.6.17.8
Date: Tue, 8 Aug 2006 21:48:11 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608082148.11433.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have had these warnings for ages:

kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
kernel/power/pm.c:64)
kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
kernel/power/pm.c:64)
kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
kernel/power/pm.c:97)
kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
kernel/power/pm.c:97)
kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
kernel/power/pm.c:216)
kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
kernel/power/pm.c:216)

and I think at one time there was a fix about that I applied, but it seems it 
never made it into kernel.org.

Or is this my ggc problem?

Thanks,

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
