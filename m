Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJBHo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJBHo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJBHo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:44:56 -0400
Received: from gyre.weather.fi ([193.94.59.26]:13730 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S267335AbUJBHob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:44:31 -0400
Date: Sat, 2 Oct 2004 10:44:15 +0300 (EEST)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410021038060.25679@gyre.weather.fi>
References: <20040922131210.6c08b94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
...
> - Found (and fixed) the bug which was causing those
>   ext3-goes-readonly-under-load problems.  It was in the new wait/wakeup code.

Forgive me for asking a question that probably enough research would
answer, but which exact patch of those listed does fix this problem?  I
cannot find the right one myself, and I would like to just address this
problem that has haunted me at least since 2.6.6, I guess.  Or is the fix
too interdependent with other changes?

-- 
Jaakko.Hyvatti@iki.fi         http://www.iki.fi/hyvatti/        +358 40 5011222
echo 'movl $36,%eax;int $128;movl $0,%ebx;movl $1,%eax;int $128'|as -o/bin/sync
