Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJVIW0>; Tue, 22 Oct 2002 04:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJVIW0>; Tue, 22 Oct 2002 04:22:26 -0400
Received: from pc132.utati.net ([216.143.22.132]:53120 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262250AbSJVIWX>; Tue, 22 Oct 2002 04:22:23 -0400
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Bride of crunch time: list 1.3-ish (was Re: 2.6: Shortlist of Missing Features)
Date: Mon, 21 Oct 2002 22:28:34 -0500
User-Agent: KMail/1.4.3
Cc: Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, davej@suse.de, davem@redhat.com,
       Guillaume Boissiere <boissiere@adiglobal.com>, mingo@redhat.com
References: <20021022043451.4989A2C05B@lists.samba.org>
In-Reply-To: <20021022043451.4989A2C05B@lists.samba.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_MN5DUZKEI1ELQVM8E905"
Message-Id: <200210212228.34355.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_MN5DUZKEI1ELQVM8E905
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 21 October 2002 22:42, Rusty Russell wrote:

> OK, here is my current list.
> Rusty.

And for reference, here's my current list (not yet collated with yours). =
 In=20
theory, both of these will feed into Guillaume's current list.  What's go=
ing=20
to feed into Linus's current list is anybody's guess...

Rob
--------------Boundary-00=_MN5DUZKEI1ELQVM8E905
Content-Type: text/plain;
  charset="utf-8";
  name="2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.txt"

More version skew:

Jeff Garzik tells me zerocopy NFS is merged already.

-----

Linus returns from the Linux Lunacy Cruise after Sunday, October 27th.
(By the time you read this, he should be in Cozumel, Mexico.  En route
to Grand Cayman, Jamaica, the Bahamas, and Ft Lauderdale.  See
http://www.geekcruises.com/itinerary/ll2_itinerary.html )

The following features aim to be ready for submission to Linus by Monday,
October 28th, to be considered for inclusion (in 2.5.45) before the feature
freeze on Thursday, October 31 (halloween).

Note: if you want to submit a new entry to this list, PLEASE provide a URL
to where the patch can be found, and any descriptive announcement you think
useful (user space tools, etc).  This doesn't have to be a web page devoted
to the patch, if the patch has been posted to linux-kernel a URL to the post
on any linux-kernel archive site is fine.

If you don't know of one, a good site for looking at the threaded archive is:
http://lists.insecure.org/lists/linux-kernel/
and a more searchable archive is available at:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&group=mlist.linux.kernel

This list is just pending features trying to get in before feature freeze.
If you want to know what's already gone in, or what's being worked on for
the next development cycle, check out "http://kernelnewbies.org/status".

You can get Andrew Morton's MM tree here:

http://www.zipworld.com.au/~akpm/linux/patches/2.5

And Alan Cox's -ac tree here:

http://www.kernel.org/pub/linux/kernel/people/alan/

And now, in no particular order:

============================ Pending features: =============================

1) Roman  Zippel's new kernel configuration system.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code: http://www.xs4all.nl/~zippel/lc/

Linus has actually looked fairly favorably on this one so far:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3250.html

2) Ted Tso's new ext2/ext3 code with extended attributes and access control
lists.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code: bk://extfs.bkbits.net/extfs-2.5-update http://thunk.org/tytso/linux/extfs-2.5

Andreas Dilger says ext3 EA+ACL is now in the -mm tree.

3) Linux Trace Toolkit (LTT) (Karim Yaghmour)
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html
Patch: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
User tools: http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

4) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac tree)
http://www.sistina.com/products_lvm.htm

5) VM large page support  (Many people) (in -mm tree)
http://lse.sourceforge.net/

6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
(A newer version of which seems to be at:)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

7) Kernel Probes/Dynamic Probes  (IBM dprobes team, contact: Vamsi Krishna S)
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

8) High resolution timers (George Anzinger, etc.)
http://high-res-timers.sourceforge.net/

Linus has unresolved concerns with this one:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3463.html

9) EVMS (Enterprise Volume Management System) (EVMS team)
http://sourceforge.net/projects/evms

10) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
Code: http://lkcd.sourceforge.net/

11) Rewrite of the console layer (James Simmons)
http://linuxconsole.sourceforge.net/

12) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

13) USAGI IPv6 (Yoshifujy Hideyaki)
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/

14) MMU-less processor support (Greg Ungerer)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7027.html

15) sys_epoll (Davide Libenzi)
homepage: http://www.xmailserver.org/linux-patches/nio-improve.html
patch: http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.5.diff

Linus participated repeatedly in a thread on this one too, expressing
concerns which (hopefully) have been addressed.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6428.html

16) Kernel Hooks (IBM kernel team, contact: Richard J. Moore.)
http://www-124.ibm.com/linux/projects/kernelhooks/

17) CD Recording/sgio patches (Jens Axboe)
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/

18) In-kernel module loader (Rusty Russell.)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

19) Unlimited groups patch (Tim Hockin.)
Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761319825&w=2
Patch set:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524717119443&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761819834&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761619831&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761519829&w=2

======================== Unresolved issues: =========================

1) Kernel Probes  (Vamsi Krishna S)

Is this the same as dynamic probes?

2) Unified boot/parameter support (Rusty Russell)
3) Hotplug CPU removal (Rusty Russell)

Patches are available under:

http://www.kernel.org/pub/linux/kernel/people/rusty/patches

But there are a lot of them, and it's not quite clear what to
apply in what order.  (I know Linus likes 'em broken up, but
an description and a pointer to a roll-up patch would be nice
for civilian testers.  I moved the in-kernel module loader to
the main list because I found an announcement posting for it.)

4) hyperthread-aware scheduler
5) connection tracking optimizations.

No URLs to patch.  Anybody want to come out in favor of these
with an announcement and pointer to a version being suggested
for inclusion?

6) IPSEC (David Miller, Alexy)
7) New CryptoAPI (James Morris)

David S. Miller said:

> No URLs, being coded as I type this :-)
>
> Some of the ipv4 infrastructure is in 2.5.44

Note, this may conflict with Yoshifuji Hideyaki's ipv6 ipsec stuff.  If not,
I'd like to collate or clarify the entries.)  USAGI ipv6 is in the first
section and this isn't because I have a URL to an existing patch to
USAGI, and don't for this.  I have no idea how much overlap there is
between these projects, and whether they're considered parts of the
same project or submitted individually...

8) ReiserFS 4

Hans Reiser said:

> We will send Reiser4 out soon, probably around the 27th.
>
> Hans

See also http://www.namesys.com/v4/fast_reiser4.html

Hans and Jens Axboe are arguing about whether or not Reiser4 is a
potential post-freeze addition.  That thread starts here:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7140.html

9) 32bit dev_t

Alan Cox said:

> The big one missing is 32bit dev_t. Thats the killer item we have left.

But did not provide a URL to a patch. :)

He also mentioned:

> Oh other one I missed - DVB layer - digital tv etc. Pretty much
> essential now for europe, but again its basically all driver layer

But it's not clear this is an item that must go in before feature freeze
or not at all.

10) initramfs

It may be on its way in already.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1110.html
--------------Boundary-00=_MN5DUZKEI1ELQVM8E905--

