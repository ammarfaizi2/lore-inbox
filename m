Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129751AbQKKNwE>; Sat, 11 Nov 2000 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbQKKNv4>; Sat, 11 Nov 2000 08:51:56 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:58103 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129714AbQKKNvj>; Sat, 11 Nov 2000 08:51:39 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Max Inux <maxinux@bigfoot.com>, H Peter Anvin <hpa@transmeta.com>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Date: Sat, 11 Nov 2000 13:49:29 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0011110323020.10847-100000@shambat>
In-Reply-To: <Pine.LNX.4.30.0011110323020.10847-100000@shambat>
MIME-Version: 1.0
Message-Id: <00111113514000.08702@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Max Inux wrote:
> >gzip, actually.  I can verify here "make bzImage" does the expected thing
> >and it looks normal-sized to me.
> 
> I believe there is zImage (gzip) and bzImage (bzip2). (Or is it compress
> vs gzip, but then why bzImage vs gzImage?)

Neither. They are both compressed the same way (gzip, IIRC) - the difference is
in how they are loaded. bzImage (= BIG zImage) has a loader which can handle
>1Mb RAM; zImage has to be loaded into normal DOS memory, so it has a size
limitation.

> >> On x86 machines there is a size limitation on booting.  Though I thought
> >> it was 1024K as the max, 900K should be fine.
> >>
> >
> >No, there isn't.  There used to be, but it has been fixed.
> 
> Ok then, I was on crank, and apparently so is he =)

ROFL! What is this "crank" stuff, BTW - some sort of auto lubricant, or ...?


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
