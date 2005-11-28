Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVK1MGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVK1MGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVK1MGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:06:11 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:44736 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751250AbVK1MGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:06:10 -0500
Subject: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 07:05:54 -0500
Message-Id: <1133179554.11491.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

With -rt20 on the AMD64 x2, I'm getting a crap load of these:

read_tsc: ACK! TSC went backward! Unsynced TSCs?

So bad that the system wont even boot (at least I won't wait long enough
to let it finish).

config at: http://www.kihontech.com/tests/rt/config

-- Steve


