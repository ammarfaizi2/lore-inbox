Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSIAMMU>; Sun, 1 Sep 2002 08:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSIAMMT>; Sun, 1 Sep 2002 08:12:19 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:22710 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S316789AbSIAMMT>;
	Sun, 1 Sep 2002 08:12:19 -0400
Message-ID: <1030882605.3d72052d591fd@kolivas.net>
Date: Sun,  1 Sep 2002 22:16:45 +1000
From: Con Kolivas <conman@kolivas.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM changes added to performance patches for 2.4.19
References: <Pine.LNX.3.96.1020901072631.337B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020901072631.337B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill Davidsen <davidsen@tmr.com>:
> On Sat, 24 Aug 2002 conman@kolivas.net wrote:
> > With the patch against 2.4.19:
> > Scheduler O(1), Preemptible, Low Latency
> > I have now added two extra alternative patches that include 
> > either Rik's rmap (thanks Rik) or AA's vm changes (thanks to Nuno Monteiro
> for
> > merging this)
> > For the record, with the (very) brief usage of these two patches I found
> the
> > rmap patch a little faster. This is very subjective and completely
> untested.
> > Check them out here and tell me what you think(please read the FAQ):
> > http://kernel.kolivas.net
> 
> The ck3-aa patch has worked perfectly for me until I try to shut down. At
> that point I get to "turning off swap" and the system hangs with the disk
> light on. Can't get a dump, and it doesn't happen every time, but enough
> that I am very cautious in what I do at shutdown. Total hang ignoring
> sysreq.
> 
> Athlon 1.4GHz, 1GB RAM, hda:30GB, hdc:40GB, 20x CD-R, multiple NICs, two
> local networks, one PPP over high speed serial.

Check on the website and you'll see that there have been two upgrades. The -ck5
patch now includes the -aa vm changes by default, and the hang on shutdown (due
to swapoff failing) has been fixed. For the record, the ck5 patch is the last
one until a new compressed cache patch becomes available for 2.4.19 and I will
merge that to make a -ck6 patch. The ck5 patch has proven to be very stable and
I am satisfied that it needs no further changes till the compressed cache patch
becomes available, so I recommend you upgrade to that.

Regards,
Con Kolivas.
