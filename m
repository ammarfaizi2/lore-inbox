Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWFTK6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWFTK6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWFTK6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:58:17 -0400
Received: from mail.gmx.de ([213.165.64.21]:40162 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932590AbWFTK6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:58:17 -0400
Content-Type: text/plain; charset="utf-8"
Date: Tue, 20 Jun 2006 12:58:15 +0200
From: "Oliver Spang" <Oliver.Spang@gmx.de>
Message-ID: <20060620105815.72010@gmx.net>
MIME-Version: 1.0
Subject: spinlock recursion bug
To: linux-kernel@vger.kernel.org
X-Authenticated: #480886
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arghhh, forgot the subject, so sorry for the repost:

I got the following bug from the kernel (2.6.16):
BUG: Spinlock recursion on CPU#0, swapped/0 (not tained)
         lock d94566c4, .magic:dead4ead, .owner: swapper/0, .owner_cpu:0
         BUG: Spinloc lockup on CPU#0, swapper/0, d94566c4 (not tained)

Unfortunately there is no dump or call trace afterwards, and the address of the lock isn't the same on each crash.
Could you give me a hint how to get a call trace after the crash, or can I somehow resolve the address of the lock to a symbol?

Can you please CC me, because I'm not subscribed to the list.

Regards,
Oliver
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
