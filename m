Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316479AbSEOUDp>; Wed, 15 May 2002 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316480AbSEOUDp>; Wed, 15 May 2002 16:03:45 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34806 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316479AbSEOUDo>; Wed, 15 May 2002 16:03:44 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020515122003.A13795@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 21:03:40 +0100
Message-ID: <18732.1021493020@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
> FYI, if they do a 
> 	bk send -ubk://linux.bkbits.net/linux-2.5 torvalds@transmeta.com
> that problem goes away.  The -u<url> stuff does the same sort of
> handshake that a pull does to figure out what needs to be sent to fill
> in the holes.

Not quite. The sender usually omits changesets for a _reason_. You'll often
find that one of the changesets in the middle wasn't necessary and didn't
touch any of the same files -- in which case patches would have applied 
just fine.

--
dwmw2


