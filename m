Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268553AbTBWUMK>; Sun, 23 Feb 2003 15:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbTBWUMK>; Sun, 23 Feb 2003 15:12:10 -0500
Received: from ns0.cobite.com ([208.222.80.10]:37645 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S268553AbTBWUMI>;
	Sun, 23 Feb 2003 15:12:08 -0500
Date: Sun, 23 Feb 2003 15:22:11 -0500 (EST)
From: David Mansfield <david@cobite.com>
X-X-Sender: david@admin
To: Rik van Riel <riel@imladris.surriel.com>
cc: David Mansfield <lkml@dm.cobite.com>, <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <Pine.LNX.4.50L.0302231711500.2206-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0302231519520.23778-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > If you read my post, the bug is that the kernel CANNOT kill that
> > process?  Why?  If it's really a bad process, shouldn't it be the one
> > that gets killed?
> 
> > This is my question, and I don't see how the patch addresses it.
> 
> And you won't see one, either.  You cannot change the
> semantics of uninterruptible sleep, nor can the OOM
> killer change other device driver things.

So you're saying that a process can stay in the D state, without ever 
getting enough resources to complete a single Uninteruptible wait, for 
hours at a time?

Ok.  Now I understand your patch.  Thanks for the info.

You should push your patch to Marcelo. 

Thanks,
David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

