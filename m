Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUD3TBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUD3TBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265220AbUD3TBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:01:40 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:27337 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S265219AbUD3TBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:01:36 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Apr 2004 20:01:35 +0100
MIME-Version: 1.0
Subject: patch-2.6.5.gz build error
Message-ID: <4092B09F.32629.4812E67D@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Tonight I installed patch-2.6.5.gz to a 2.6.4 build tree - patch file 
from:

http://www.kernel.org/pub/linux/kernel/v2.6/

and whilst building, GCC exited with Error 1 in:

include/linux/module.h: Line 53

const struct exception_table_entry *

I couldn't see anything wrong (as if _I_ would know anyway ;) ), but 
guessed a bit, so removed the white space and re-added it, plus 
newlined it at the end, all in nano, and then the build all worked 
OK.

Looks like a strange char is added somewhere in that patch (or patch 
tool adds it?).

Regards,

Nick
(Not subscribed to list).

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

