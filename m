Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbSJaSLE>; Thu, 31 Oct 2002 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSJaSJ6>; Thu, 31 Oct 2002 13:09:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:24554 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262859AbSJaSJ2>;
	Thu, 31 Oct 2002 13:09:28 -0500
Message-ID: <3DC17354.943DAC97@digeo.com>
Date: Thu, 31 Oct 2002 10:15:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210310900130.20412-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2002 18:15:48.0650 (UTC) FILETIME=[89CE90A0:01C28109]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> [ lkcd ]
>

We'll be spending the next six months stabilising and hardening
the used-to-be-2.5 kernel.  If grunts like me can get hold a
copy of the other person's kernel image from time-of-crash, that
has a ton of value.

(Disclaimer: I've never used lkcd.  I'm assuming that it's
possible to gdb around in a dump)

>         In particular when it comes to this project, I'm told about
>         "netdump", which doesn't try to dump to a disk, but over the net.

It could help.  But like serial console, the random person whose
kernel just died often can't be bothered setting it up, or simply
doesn't have the gear, or the crash is not repeatable.


So.  _If_ lkcd gives me gdb-able images from time-of-crash, I'd
like it please.  And I'm the grunt who spent nearly two years
doing not much else apart from working 2.3/2.4 oops reports.


Oh, and as Rusty has pointed out, we lose a *lot* of oops reports
because users are in X and the backtrace doesn't make it to the
logs.  Rusty has a little app which dumps just the oops report to
disk somewhere.    Want that too.
