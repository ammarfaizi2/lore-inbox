Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291701AbSBHSRE>; Fri, 8 Feb 2002 13:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291704AbSBHSQo>; Fri, 8 Feb 2002 13:16:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291701AbSBHSQg>; Fri, 8 Feb 2002 13:16:36 -0500
Date: Fri, 8 Feb 2002 12:02:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
X-X-Sender: <torvalds@athlon>
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        <akpm@zip.com.au>, <mingo@elte.hu>, <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C641511.9555ED47@dlr.de>
Message-ID: <Pine.LNX.4.33.0202081201540.10896-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Martin Wirth wrote:
>
> There are currently several attempts discussed to push out the
> BKL and replace it by a semaphore e.g. the next step Robert Love
> planned for his ll_seek patch (replace the BKL by inode i_sem).

But that won't have any contention anyway, so it's a non-issue.

		Linus

