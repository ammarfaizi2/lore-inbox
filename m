Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282817AbRLBJO0>; Sun, 2 Dec 2001 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282816AbRLBJOR>; Sun, 2 Dec 2001 04:14:17 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:50371 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282817AbRLBJOA>; Sun, 2 Dec 2001 04:14:00 -0500
Date: 01 Dec 2001 23:45:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8E1ezUo1w-B@khms.westfalen.de>
In-Reply-To: <9u8qtu$u2b$1@cesium.transmeta.com>
Subject: Re: Coding style - a non-issue
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <9u8qtu$u2b$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 30.11.01 in <9u8qtu$u2b$1@cesium.transmeta.com>:

> By author:    Jeff Garzik <jgarzik@mandrakesoft.com>

> > "Paul G. Allen" wrote:
> > > IMEO, there is but one source as reference for coding style: A book by
> > > the name of "Code Complete". (Sorry, I can't remember the author and I
> > > no longer have a copy. Maybe my Brother will chime in here and fill in
> > > the blanks since he still has his copy.)
> >
> > Hungarian notation???
> >
> > That was developed by programmers with apparently no skill to
> > see/remember how a variable is defined.  IMHO in the Linux community
> > it's widely considered one of the worst coding styles possible.
> >
>
> Indeed.  What can you say for a technique which basically promotes
> *reducing* abstraction and information hiding?
>
> There is a reason why the Win64 ABI uses the same "int" and "long" as
> Win32... (both are 32 bits.)  They added meaningless abstractions, and
> didn't add abstractions where they needed to...

Well, that doesn't necessarily make the idea itself completely crap just  
because the standard implementation is.

Sure, calling a variable "I point to a char! And by the way, I'm named  
Fritz" may be a bad idea, but in some situations it may well make sense to  
say that a certain variable is a container and another is a lock.

And it seems that sometimes, the kernel does just that. (pagecache_lock,  
page_list, just picking two fast examples from 2.4.0 mm)

But lpfilename is, indeed, fucking insane.


MfG Kai
