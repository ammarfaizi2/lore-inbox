Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSGOTXv>; Mon, 15 Jul 2002 15:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGOTXu>; Mon, 15 Jul 2002 15:23:50 -0400
Received: from noc.easyspace.net ([62.254.202.67]:31240 "EHLO
	noc.easyspace.net") by vger.kernel.org with ESMTP
	id <S317604AbSGOTXt>; Mon, 15 Jul 2002 15:23:49 -0400
Date: Mon, 15 Jul 2002 20:26:20 +0100
From: Sam Vilain <sam@vilain.net>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <xltlm8c6d7b.fsf@shookay.newview.com>
References: <1026490866.5316.41.camel@thud>
	<E17U9x9-0001Dc-00@hofmann>
	<xltlm8c6d7b.fsf@shookay.newview.com>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17UBUC-0001Nb-00@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer <mathieu@newview.com> wrote:

> >   - there is a `dump' command (but it's useless, because it hangs when you
> >     run it on mounted filesystems - come on, who REALLY unmounts their
> >     filesystems for a nightly dump?  You need a 3 way mirror to do it
> >     while guaranteeing filesystem availability...)
> According to everybody, dump is deprecated (and it shouldn't work reliably
> with 2.4, in two words: "forget it")...

It's a shame, because `tar' doesn't save things like inode attributes and
places unnecessary load on the VFS layer.  It also takes considerably
longer than dump did on one backup server I admin - like ~12 hours to back
up ~26G in ~414k inodes to a tape capable of about 1MB/sec.  But that's
probably the old directory hashing thing again, there are some
reeeeaaallllllly large directories on that machine...

Ah, the joys of legacy. 
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

  If you think the United States has stood still, who built the
largest shopping center in the world?
RICHARD M NIXON
