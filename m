Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUB0P2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUB0P2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:28:34 -0500
Received: from [213.227.237.65] ([213.227.237.65]:15233 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S263007AbUB0P2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:28:33 -0500
Subject: Debian 2.6.2 & CONFIG_PREEMPT & ps/2 keyboard
From: Alex Lyashkov <shadow@psoft.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: PSoft
Message-Id: <1077895709.31768.40.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 27 Feb 2004 17:28:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

At current I try to use 2.6.2 kernel from debian distribution.
After start XFree I see 
==
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
==
Well, i search at list archives and see disable CONFIG_PREEMPT
can be solution at this situations. I disable it recompile kernel and
see XFree started without this messages.
After one-two hour i returned to work with this computer and see
messages again.

I think this problem is CONFIG_PREEMPT related, not a XFree bug.


-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
