Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316486AbSEOURU>; Wed, 15 May 2002 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316482AbSEOURT>; Wed, 15 May 2002 16:17:19 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:247 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316498AbSEOUPi>; Wed, 15 May 2002 16:15:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020515130831.C13795@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 21:15:37 +0100
Message-ID: <19065.1021493737@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
> It's probably best if you simply view this as a BK limitation which
> isn't going away any time soon and don't put junk changesets in the
> middle of your stream of changes.  It's easy enough to export the
> change you want as a patch, export the comments in the form that bk
> comments wants, undo the junk changeset, import the patch, and set the
> comments.  Yeah, it's awkward; consider that a feedback loop which
> encourages you to think a bit more about what you put in the tree.

What it actually encourages is for people to have multiple throwaway trees. 
(Which isn't quite so much of a BK turnoff once you discover compilercache.)

If the tree's going to be thrown away anyway, it doesn't matter if it gets 
confused -- how about making it a little easier to backport changesets -- 
surely it should be possible to make BK import a changeset iff all the 
affected files are identical in both trees before the changeset? 

--
dwmw2


