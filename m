Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRADLJB>; Thu, 4 Jan 2001 06:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132266AbRADLIl>; Thu, 4 Jan 2001 06:08:41 -0500
Received: from smtp.mountain.net ([198.77.1.35]:9231 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129641AbRADLIi>;
	Thu, 4 Jan 2001 06:08:38 -0500
Message-ID: <3A5459A3.6F9F7B2A@mountain.net>
Date: Thu, 04 Jan 2001 06:08:19 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-prerelease i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] testing/prerelease of 01/03 on startup
In-Reply-To: <Pine.LNX.4.10.10101040117370.15040-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Jan 2001, Tom Leete wrote:
> >
> > kernel is 2.4.0-prerelease with testing/prerelease patch of Jan. 3, i486.
> > Oops is repeatable.
> 
> Looks like your mm->mmlist list is corrupted from the very start.
> 
> Can you humor me and make sure you do a "make clean" and re-check your
> prerelease patch? Is the initialization of mmlist there in linux/sched.h,
> for example?
> 
>                 Linus

Ahh... oops is on me.

Patch was ok, but there must have been cruft from another build. A rebuild
from clean seems to have cured it.

Sorry for the noise,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
