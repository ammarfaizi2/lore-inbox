Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSJULRJ>; Mon, 21 Oct 2002 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJULRJ>; Mon, 21 Oct 2002 07:17:09 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:56483 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S261324AbSJULRG>; Mon, 21 Oct 2002 07:17:06 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, landley@trommello.org
Date: Mon, 21 Oct 2002 07:22:38 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  October 21, 2002
CC: riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, davem@redhat.com,
       "Guillaume Boissiere" <boissiere@adiglobal.com>, mingo@redhat.com
Message-ID: <3DB3AB3E.23020.5FFF7144@localhost>
References: <20021021135137.2801edd2.rusty@rustcorp.com.au>
In-reply-to: <200210202144.59787.landley@trommello.org>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [64.152.17.166] at Mon, 21 Oct 2002 06:23:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated my list with changes pointed out by Rob and Rusty.

http://www.kernelnewbies.org/status/

I am not too clear what exactly is expected to be merged for 
IPv6 (everything from USAGI?) so I removed it and replaced 
by IPsec and CryptoAPI.  
Also, are initramfs, ext2/3 resize for 2.7/3.1?

-- Guillaume



On 20 Oct 2002 at 21:44, Rob Landley wrote:

> On Sunday 20 October 2002 22:51, Rusty Russell wrote:
> > On Sun, 20 Oct 2002 14:59:58 +0200 (CEST)
> >
> > Roman Zippel <zippel@linux-m68k.org> wrote:
> > > But now would be a good time to recapitulate things which Linus might
> > > have forgotten in the patching frenzy.
> >
> > Yes.  If we only consider new arch-independent features which are actively
> > being pushed at the moment and are feature complete, I get the following
> > (much stolen from Guilluame: thanks!):
> 
> Sigh.  If great minds think alike, how do you explain either of us then? :)
> 
> Collating time...
> 
> I'm trying to get URLs to patches with my list.  (You'll notice Guilluame's 
> list has URLs, some of which are a bit out of date).
> 
> Here's a quick and dirty cut and paste of my list so far:
> 
> Roman  Zippel's new kernel configuration system.
> Announcement:
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
> Code:
> http://www.xs4all.nl/~zippel/lc/
> 
> 
> Ted Tso's new ext2/ext3 code with extended attributes and 
> access control lists.
> Announcement:
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
> Code (chooe your poison):
> bk://extfs.bkbits.net/extfs-2.5-update 
> http://thunk.org/tytso/linux/extfs-2.5
> 
> 
> > > o Ready - Build option for Linux Trace Toolkit (LTT) (Karim Yaghmour)
> > > http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
> >
> > LTT has seen a number of changes since the posting above. Mainly,
> > we've followed the recommendations of quite a few folks from the LKML.
> > Here are some highlights summarizing the changes:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
> >
> > The latest patch is available here:
> > http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-
> >021019-2.2.bz2 Use this patch with version 0.9.6pre2 of the user tools:
> > http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz
> >
> > Karim
> 
> And other stuff from the original 2.5 status list's "ready" stuff (with URLs):
> 
> o in -ac PCMCIA Zoom video support (Alan Cox) 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html
> 
> o in -ac Device mapper for Logical Volume Manager (LVM2)  (LVM2 team) 
> http://www.sistina.com/products_lvm.htm
> 
> o in -mm VM large page support  (Many people) 
> http://lse.sourceforge.net/
> 
> o in -mm  Page table sharing  (Daniel Phillips, Dave McCracken) 
> http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
> (A newer version of which seems to be at:)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html
> 
> o Ready - Dynamic Probes (dprobes team) 
> http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes
> 
> o Ready - Zerocopy NFS (Hirokazu Takahashi) 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html
> 
> o Ready - High resolution timers (George Anzinger, etc.) 
> http://high-res-timers.sourceforge.net/
> 
> o Ready - EVMS (Enterprise Volume Management System) (EVMS team) 
> http://sourceforge.net/projects/evms
> 
> o Ready - Linux Kernel Crash Dumps (Matt Robinson, LKCD team) 
> http://lkcd.sourceforge.net/
> 
> o Ready - Rewrite of the console layer (James Simmons) 
> http://linuxconsole.sourceforge.net/
> 
> To the above can be added the following recent submission on the list:
> 
> o Ready- Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html
> 
> Now let's look what that leaves on your list:
> 
> > - Kernel Probes  (Vamsi Krishna S)
> 
> Is this the same as dynamic probes?
> 
> > - In-kernel module loader (Rusty Russell)
> > - Unified boot/parameter support (Rusty Russell)
> > - Hotplug CPU removal (Rusty Russell)
> 
> I believe these are new.  Do you have URLs?
> 
> > The rest (eg. hyperthread-aware scheduler, connection tracking
> > optimizations) don't really qualify as major new features as far as I can
> > tell.
> >
> > To ensure none of these get simply missed (rather than an actual decision
> > not to include them), it'd be nice to actually get "NAK"s once Linus gets
> > back.  And at least if we have a finite "possible" list, we can judge how
> > frozen we really are.
> 
> Replying to you, David S. Miller added:
> 
> > IPSEC from Alexey and myself, and new CryptoAPI from James Morris.
> 
> URLs to which would be nice.
> 
> And In a reply to me, Hans Reiser promised Reiser 4 by the 27th.  (That's when 
> the cruise Linus is on ends, see my first "crunch time" post.)  No URL yet, 
> since the code isn't done.
> 
> > It's a relatively short list: how many am I missing?  (Dave?)
> > Rusty.
> 
> That's all I know, collated into one amazingly ugly post.  (Showing that even 
> with Red Hat 8's new pretty fonts, you can still cut and paste together an 
> incomprehensible, terribly formatted email.  It's just more of a challenge. 
> :)
> 
> Rob


