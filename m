Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbTDGCQr (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbTDGCQr (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:16:47 -0400
Received: from [12.47.58.55] ([12.47.58.55]:16087 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263192AbTDGCQq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:16:46 -0400
Date: Sun, 6 Apr 2003 18:28:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12 causes "rpm" errors
Message-Id: <20030406182815.65dd9304.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
References: <20030406183234.1e8abd7f.akpm@digeo.com>
	<Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 02:28:11.0906 (UTC) FILETIME=[55D06E20:01C2FCAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> wrote:
>
> > The only change which comes to mind is the below one.  Could you do a
> > patch -R of this and retest?
> 
> ... patch deleted ...
> 
> that fixed it, but i only this second noticed the "-R" for reversing
> the patch.  i applied it normally against my 2.5.66-bk12 tree, and
> it apparently applied cleanly.  
> 
> wouldn't that suggest that that patch wasn't in my tree in the first
> place?  i'm sure i'm up to bk12 at this point.
> 

I am now very confused.

That patch _is_ in 2.5.66-bk12.  If a `patch -R' of that patch made bk12 work
correctly then the patch was the source of the changed behaviour.

Please start again ;)

Test 2.5.66, then 2.5.66-bk12, then 2.5.66-bk12 with a `patch -R' of
the patch which I sent in the earlier email.

Thanks again.
