Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTBIDYR>; Sat, 8 Feb 2003 22:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBIDYR>; Sat, 8 Feb 2003 22:24:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31139 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267155AbTBIDYR>; Sat, 8 Feb 2003 22:24:17 -0500
Date: Sat, 8 Feb 2003 19:33:49 -0800
Message-Id: <200302090333.h193Xnn04935@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@digeo.com>, <arjanv@redhat.com>
X-Fcc: ~/Mail/linus
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Roland McGrath's message of  Saturday, 8 February 2003 19:30:45 -0800 <200302090330.h193UjR04919@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
Emacs: freely redistributable; void where prohibited by law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah.  Deciding state should be treated as a bitmask is not so hot when
TASK_RUNNING is 0.
