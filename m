Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSLKBcT>; Tue, 10 Dec 2002 20:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSLKBcT>; Tue, 10 Dec 2002 20:32:19 -0500
Received: from bitmover.com ([192.132.92.2]:5329 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266948AbSLKBcS>;
	Tue, 10 Dec 2002 20:32:18 -0500
Date: Tue, 10 Dec 2002 17:40:01 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200212110140.gBB1e1o30094@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [BK prob] - bogus cset
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm an idiot, in the process of optimizing the logging code (so you modem
users send less data, a big deal in Europe), I put a test cset into the
main tree at bk://linux.bkbits.net/linux-2.5 and a pile of people pulled
it.  

Could you please do this:

bk findkey 'lm@work.bitmover.com|ChangeSet|20021211000341|36093' ChangeSet

If that returns nothing, you're fine.  If it tells you a revision, then
if that is the most recent revision, just do a 

	bk undo -fr`bk findkey 'lm@work.bitmover.com|ChangeSet|20021211000341|36093' ChangeSet`

and you're all set.  If that isn't the most recent revision, i.e., you merged
against that, send me an email and I'll straighten out the tree.

Sorry about this, it won't happen again.

--lm
