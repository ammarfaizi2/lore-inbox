Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261879AbSJVBaV>; Mon, 21 Oct 2002 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSJVBaV>; Mon, 21 Oct 2002 21:30:21 -0400
Received: from pc132.utati.net ([216.143.22.132]:39552 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261879AbSJVBaS> convert rfc822-to-8bit; Mon, 21 Oct 2002 21:30:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: "Guillaume Boissiere" <boissiere@adiglobal.com>
Subject: Son of crunch time: the list v1.2.
Date: Mon, 21 Oct 2002 15:36:25 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost>
In-Reply-To: <3DB3AB3E.23020.5FFF7144@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210211536.25109.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus returns from the Linux Lunacy Cruise after Sunday, October 27th.  The
following features aim to be ready for submission to Linus by Monday, October
28th, to be considered for inclusion (in 2.5.45) before the feature freeze on
Thursday, October 31 (halloween).

Note: if you want to submit a new entry to this list, PLEASE provide a URL
to where the patch can be found, and any descriptive announcement you think
useful (user space tools, etc).  This doesn't have to be a web page devoted
to the patch, if the patch has been posted to linux-kernel a URL to the post
on any linux-kernel archive site should  be fine.

If you don't know of one, a good site for looking at a threaded version of the 
linux-kernel archive is http://lists.insecure.org/lists/linux-kernel/
and a keyword searchable archive is available at:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&group=mlist.linux.kernel

This list is just pending features trying to get in before feature freeze.
If you want to know what's already gone in, or what's being worked on for
the next development cycle, check out "http://kernelnewbies.org/status".

And now, in no particular order:

============================ Pending features: =============================

1) Roman  Zippel's new kernel configuration system.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code: http://www.xs4all.nl/~zippel/lc/

2) Ted Tso's new ext2/ext3 code with extended attributes and access control
lists.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code: bk://extfs.bkbits.net/extfs-2.5-update 
http://thunk.org/tytso/linux/extfs-2.5

Andreas Dilger says ext3 EA+ACL is now in the -mm tree.

3) Linux Trace Toolkit (LTT) (Karim Yaghmour)
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html
Patch: 
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
User tools: http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

4) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac tree)
http://www.sistina.com/products_lvm.htm

5) VM large page support  (Many people) (in -mm tree)
http://lse.sourceforge.net/

6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
(A newer version of which seems to be at:)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

7) Dynamic Probes (dprobes team)
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

8) Zerocopy NFS (Hirokazu Takahashi)
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html

9) High resolution timers (George Anzinger, etc.)
http://high-res-timers.sourceforge.net/

10) EVMS (Enterprise Volume Management System) (EVMS team)
http://sourceforge.net/projects/evms

11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
Code: http://lkcd.sourceforge.net/

12) Rewrite of the console layer (James Simmons)
http://linuxconsole.sourceforge.net/

13) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

14) USAGI IPv6.

Yoshifuji Hideyaki points out that ipv6 is very important overseas
(where some entire countries make do with a single class B ipv4
address range).  He says:

> Well, our IPsec is ready, runs and is tested...
> ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/

15) MMU-less processor support (Greg Ungerer)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7027.html

16) sys_epoll (Davide Libenzi)
homepage: http://www.xmailserver.org/linux-patches/nio-improve.html
patch: http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.3.diff

17) Kernel Hooks (IBM kernel team, contact: Richard J. Moore.)
http://www-124.ibm.com/linux/projects/kernelhooks/

18) CD Recording/sgio patches (Jens Axboe)
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/

19) In-kernel module loader (Rusty Russell.)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

20) Unlimited groups patch (Tim Hockin.)

Older (unified) version:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1619.html

Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/3885.html
Patch set:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3884.html
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3886.html
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3888.html
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3889.html

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
with an announcement and pointer to a specific patch being
suggested for inclusion?

6) IPSEC (David Miller, Alexy)
7) New CryptoAPI (James Morris)

David S. Miller said:

> No URLs, being coded as I type this :-)
>
> Some of the ipv4 infrastructure is in 2.5.44

Note, this may conflict with Yoshifuji Hideyaki's ipv6 ipsec stuff.  If not,
I'd like to collate or clarify the entries.)  USAGI ipv6 is in the first
section and this isn't because I have a URL to an existing patch to
USAGI, and don't for this.

I actually have no idea how much overlap there is between these projects, and 
whether they're considered parts of the same project or to be submitted 
individually...

8) ReiserFS 4

Hans Reiser said:

> We will send Reiser4 out soon, probably around the 27th.
>
> Hans

See also http://www.namesys.com/v4/fast_reiser4.html

Hans and Jens Axboe are arguing about whether or not Reiser4 is a
potential post-freeze addition.  That thread starts here:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7140.html

9) Administrivia

I need to find a patch-friendly archive that works with "save-as" so
cut and paste doesn't get a chance to mess up whitespace on
patches people have posted to the list a while ago...
