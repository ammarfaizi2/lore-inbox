Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSJUGcw>; Mon, 21 Oct 2002 02:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbSJUGcv>; Mon, 21 Oct 2002 02:32:51 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:62193 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264749AbSJUGct> convert rfc822-to-8bit; Mon, 21 Oct 2002 02:32:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: karim@opersys.com
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Date: Sun, 20 Oct 2002 20:37:54 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org> <3DB398C4.6DB5CB0B@opersys.com>
In-Reply-To: <3DB398C4.6DB5CB0B@opersys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202037.54370.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 01:03, Karim Yaghmour wrote:
> Rob Landley wrote:
> > o Ready - Build option for Linux Trace Toolkit (LTT) (Karim Yaghmour)
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
>
> LTT has seen a number of changes since the posting above. Mainly,
> we've followed the recommendations of quite a few folks from the LKML.
> Here are some highlights summarizing the changes:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
>
> The latest patch is available here:
> http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-
>021019-2.2.bz2 Use this patch with version 0.9.6pre2 of the user tools:
> http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz
>
> Karim

Cool.  I just grabbed the URL off of G.B's list (I'm not even going to TRY to 
spell his name again just now).  it would be nice if the october 19 link was 
up as soon as the "latest" link was up: right now I can't post a URL to it in 
a way that will remain referring to what I was talking about after he posts 
the next update. :(

Another thing I've noticed somebody still hoping to shoehorn into 2.5 is Roman 
Zippel's new kernel configuration system, which is here:

Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code:
http://www.xs4all.nl/~zippel/lc/

That was listed as a "beta" on the status list, I guess at version 1.1, it has 
now been promoted.  (Anything else on the beta that's still trying to make it 
into 2.5?  The 27th is sunday, meaning Linus should be back at transmeta on 
monday.  Assuming 2.4.45 ships on the 31st, that would be the following 
thursday...)

Ted Tso has also been posting new ext2/ext3 code with extended attributes and 
access control lists.

Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code (chooe your poison):
bk://extfs.bkbits.net/extfs-2.5-update 
http://thunk.org/tytso/linux/extfs-2.5

Apparently generic ACL support went into 2.5.3 (the status list again), but I 
guess it wasn't added to EXT2.  I suppose this makes this a good candidate 
for inclusion then. :)

So, 11 items from the 2.5 status list (in -aa, in -mm, and "ready"), plus 
kexec, kernelconfig, and ACL for EXT3.  I believe this brings the total 
number of pending patchsets still hoping for 2.5 inclusion to 14.

I can repost the full list if nobody beats me to it, but I think I'll wait to 
see who else pipes up first. :)

Rob
