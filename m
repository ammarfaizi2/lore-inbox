Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSGOIX2>; Mon, 15 Jul 2002 04:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSGOIX0>; Mon, 15 Jul 2002 04:23:26 -0400
Received: from pc2-woki1-6-cust25.gfd.cable.ntl.com ([80.6.41.25]:36224 "EHLO
	hofmann") by vger.kernel.org with ESMTP id <S317386AbSGOIXS>;
	Mon, 15 Jul 2002 04:23:18 -0400
Date: Mon, 15 Jul 2002 09:26:03 +0100
From: Sam Vilain <sam@vilain.net>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <1026679245.15054.9.camel@thud>
References: <1026490866.5316.41.camel@thud>
	<1026679245.15054.9.camel@thud>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: NErb*2NY4\th?$s.!!]_9le_WtWE'b4;dk<5ot)OW2hErS|tE6~D3errlO^fVil?{qe4Lp_m\&Ja!;>%JqlMPd27X|;b!GH'O.,NhF*)e\ln4W}kFL5c`5t'9,(~Bm_&on,0Ze"D>rFJ$Y[U""nR<Y2D<b]&|H_C<eGu?ncl.w'<
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17U1BD-0000m0-00@hofmann>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> wrote:

> > Any suggestions or comments appreciated.
> Thanks for the feedback. Look for more testing from us soon addressing
> the suggestions brought up.

One more thing - can I just make the comment that testing freshly formatted filesystems is not going to show up ext2's real weaknesses, that happen to old filesystems - particularly those where the filesystem has been allowed to fill up.

I timed *15 minutes* for a system I admin to unlink a single 1G file on a fairly old ext2 filesystem the other day (perhaps ext3 would have improved this, I'm not sure).  It took 30 minutes to scan a snort log directory log on ext2, but less than 2 minutes on reiser - and only 3 seconds once it was in the buffercache.

You are testing for a mail server - how many mailboxes are in your spool directory for the tests?  Try it with about five to ten thousand mailboxes and see how your results vary.
--
   Sam Vilain, sam@vilain.net     WWW: http://sam.vilain.net/
    7D74 2A09 B2D3 C30F F78E      GPG: http://sam.vilain.net/sam.asc
    278A A425 30A9 05B5 2F13

Although Mr Chavez 'was democratically elected,' one had to bear in
mind that 'Legitimacy is something that is conferred not just by a
majority of the voters'"
 - The office of George "Dubya" Bush commenting on the Venezuelan
   election
