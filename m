Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130387AbRAKDNL>; Wed, 10 Jan 2001 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRAKDNB>; Wed, 10 Jan 2001 22:13:01 -0500
Received: from client1154.sedona.net ([208.48.157.101]:41477 "EHLO
	toltec.metran.cx") by vger.kernel.org with ESMTP id <S130387AbRAKDMq>;
	Wed, 10 Jan 2001 22:12:46 -0500
From: Jay Ts <jay@toltec.metran.cx>
Message-Id: <200101110312.UAA06343@toltec.metran.cx>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
To: andrewm@uow.edu.au (Andrew Morton)
Date: Wed, 10 Jan 2001 20:12:18 -0700 (MST)
Cc: linux-kernel@vger.kernel.org (lkml),
        linux-audio-dev@ginette.musique.umontreal.ca (lad)
In-Reply-To: <3A57DA3E.6AB70887@uow.edu.au> from "Andrew Morton" at Jan 07, 2001 01:53:50 PM
Reply-To: jayts@bigfoot.com
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A patch against kernel 2.4.0 final which provides low-latency
> scheduling is at
> 
> 	http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads
> 
> Some notes:
> 
> - Worst-case scheduling latency with *very* intense workloads is now
>   0.8 milliseconds on a 500MHz uniprocessor.

Wow!  That's super.  Now about the only thing left is to get it included
in the standard kernel.  Do you think Linus Torvalds is more likely
to accept these patches than Ingo's?  I sure hope this one works out.

>   This is one to
>   three orders of magnitude better than BeOS, MacOS and the Windowses.

** salivates **

> - Low latency will probably only be achieved when using the ext2 and
>   NFS filesystems.

Well it's extremely nice to see NFS included at least.  I was really
worried about that one.  What about Samba?  (Keeping in mind that
serious "professional" musicians will likely have their Linux systems
networked to a Windows box, at least until they have all the necessary
tools on Linux.

> - If you care about latency, be *very* cautious about upgrading to
>   XFree86 4.x.  I'll cover this issue in a separate email, copied
>   to the XFree team.

Did that email pass by me unnoticed?  What's the prob with XF86 4.0?

- Jay Ts
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
