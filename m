Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271711AbRHQRlJ>; Fri, 17 Aug 2001 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRHQRlA>; Fri, 17 Aug 2001 13:41:00 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:63690 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S271711AbRHQRko>; Fri, 17 Aug 2001 13:40:44 -0400
Date: Fri, 17 Aug 2001 12:40:58 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext2 not NULLing deleted files?
In-Reply-To: <998034466.663.11.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0108171233360.392-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001, Robert Love wrote:
> On 17 Aug 2001 09:38:10 +0200, Enver Haase wrote:
> > I just recognized there's an "undelete" now for ext2 file systems [a KDE
> > app].
> >
> > "The Other OS" in its professional version does of course clear the deleted
> > blocks with 0's for security reasons; I would have bet a thousand bucks Linux
> > would do so, too [seems I should have read the source code, good thing no-one
> > wanted to take on the bet :) ].
>
> By "The Other OS" I assume you mean NT.  NT does _not_ zero files on
> delete, either with NTFS or anything else.  It merely unlinks them like
> any other OS.  I can't think of anything that nullifies files, except
> utilities meant solely to do that (often called "sweeping").

VMS.  "DELETE/ERASE FOO.BAR"  I don't recall whether it's done by the
filesystem code or by the DELETE command in userspace, but I'm guessing
it's built into FILES-11.  (Sorry, my Gray Wall is at home.)

> Do you have any idea how long it would take to zero files?  If you
> removed even a moderately sized directory, it would take a _very long_
> time.

That's why it's optional.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

