Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSJUHjT>; Mon, 21 Oct 2002 03:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJUHjT>; Mon, 21 Oct 2002 03:39:19 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:26848 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261218AbSJUHjR> convert rfc822-to-8bit; Mon, 21 Oct 2002 03:39:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6: Shortlist of Missing Features
Date: Sun, 20 Oct 2002 21:44:59 -0500
User-Agent: KMail/1.4.3
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, davem@redhat.com,
       "Guillaume Boissiere" <boissiere@adiglobal.com>, mingo@redhat.com
References: <Pine.LNX.4.44L.0210192357430.22993-100000@imladris.surriel.com> <Pine.LNX.4.44.0210201444460.8911-100000@serv> <20021021135137.2801edd2.rusty@rustcorp.com.au>
In-Reply-To: <20021021135137.2801edd2.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210202144.59787.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 October 2002 22:51, Rusty Russell wrote:
> On Sun, 20 Oct 2002 14:59:58 +0200 (CEST)
>
> Roman Zippel <zippel@linux-m68k.org> wrote:
> > But now would be a good time to recapitulate things which Linus might
> > have forgotten in the patching frenzy.
>
> Yes.  If we only consider new arch-independent features which are actively
> being pushed at the moment and are feature complete, I get the following
> (much stolen from Guilluame: thanks!):

Sigh.  If great minds think alike, how do you explain either of us then? :)

Collating time...

I'm trying to get URLs to patches with my list.  (You'll notice Guilluame's 
list has URLs, some of which are a bit out of date).

Here's a quick and dirty cut and paste of my list so far:

Roman  Zippel's new kernel configuration system.
Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code:
http://www.xs4all.nl/~zippel/lc/


Ted Tso's new ext2/ext3 code with extended attributes and 
access control lists.
Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code (chooe your poison):
bk://extfs.bkbits.net/extfs-2.5-update 
http://thunk.org/tytso/linux/extfs-2.5


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

And other stuff from the original 2.5 status list's "ready" stuff (with URLs):

o in -ac PCMCIA Zoom video support (Alan Cox) 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html

o in -ac Device mapper for Logical Volume Manager (LVM2)  (LVM2 team) 
http://www.sistina.com/products_lvm.htm

o in -mm VM large page support  (Many people) 
http://lse.sourceforge.net/

o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken) 
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
(A newer version of which seems to be at:)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

o Ready - Dynamic Probes (dprobes team) 
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

o Ready - Zerocopy NFS (Hirokazu Takahashi) 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html

o Ready - High resolution timers (George Anzinger, etc.) 
http://high-res-timers.sourceforge.net/

o Ready - EVMS (Enterprise Volume Management System) (EVMS team) 
http://sourceforge.net/projects/evms

o Ready - Linux Kernel Crash Dumps (Matt Robinson, LKCD team) 
http://lkcd.sourceforge.net/

o Ready - Rewrite of the console layer (James Simmons) 
http://linuxconsole.sourceforge.net/

To the above can be added the following recent submission on the list:

o Ready- Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

Now let's look what that leaves on your list:

> - Kernel Probes  (Vamsi Krishna S)

Is this the same as dynamic probes?

> - In-kernel module loader (Rusty Russell)
> - Unified boot/parameter support (Rusty Russell)
> - Hotplug CPU removal (Rusty Russell)

I believe these are new.  Do you have URLs?

> The rest (eg. hyperthread-aware scheduler, connection tracking
> optimizations) don't really qualify as major new features as far as I can
> tell.
>
> To ensure none of these get simply missed (rather than an actual decision
> not to include them), it'd be nice to actually get "NAK"s once Linus gets
> back.  And at least if we have a finite "possible" list, we can judge how
> frozen we really are.

Replying to you, David S. Miller added:

> IPSEC from Alexey and myself, and new CryptoAPI from James Morris.

URLs to which would be nice.

And In a reply to me, Hans Reiser promised Reiser 4 by the 27th.  (That's when 
the cruise Linus is on ends, see my first "crunch time" post.)  No URL yet, 
since the code isn't done.

> It's a relatively short list: how many am I missing?  (Dave?)
> Rusty.

That's all I know, collated into one amazingly ugly post.  (Showing that even 
with Red Hat 8's new pretty fonts, you can still cut and paste together an 
incomprehensible, terribly formatted email.  It's just more of a challenge. 
:)

Rob
