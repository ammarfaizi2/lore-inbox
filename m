Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319273AbSIEW7p>; Thu, 5 Sep 2002 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319276AbSIEW7p>; Thu, 5 Sep 2002 18:59:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62098 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319273AbSIEW7m>;
	Thu, 5 Sep 2002 18:59:42 -0400
Date: Fri, 6 Sep 2002 01:08:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905230250.GC14295@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060108410.21120-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> OK.  I think that the !list_empty (ptrace_children) isn't really enough
> - since there can be things on our children list that we will not wait
> for - should we be iterating over it making the same checks we do above?

yes, i think so.

	Ingo

