Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135660AbRDXPA7>; Tue, 24 Apr 2001 11:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135669AbRDXPAu>; Tue, 24 Apr 2001 11:00:50 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:45581 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S135672AbRDXPAm>; Tue, 24 Apr 2001 11:00:42 -0400
Date: Wed, 25 Apr 2001 00:59:33 +1000
From: CaT <cat@zip.com.au>
To: Pjotr Kourzanoff <pjotr@suselinux.hu>
Cc: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010425005933.G1245@zip.com.au>
In-Reply-To: <20010424163009.A7197@vega.digitel2002.hu> <Pine.LNX.4.31.0104241643400.17653-100000@zeus.suselinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104241643400.17653-100000@zeus.suselinux.hu>; from pjotr@suselinux.hu on Tue, Apr 24, 2001 at 04:49:57PM +0200
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 04:49:57PM +0200, Pjotr Kourzanoff wrote:
> > use port 2525 as SMTP port in your MTA. I've succeed to setup such a
> > configuration.
> 
>   This requires you to ensure that your MTA is started first on that
>   port...Might be difficult to achieve reliably in an automatic way
>   without root privileges :-(
> 
>   mailuser@foo% /etc/rc.d/init.d/sendmail stop
>   badguy@foo% ./suck 2525
>   mailuser@foo% /etc/rc.d/init.d/sendmail start

Not necessarily. While I have no yet used the feature, iptables
permits firewalling on userid. I presume this includes wether or
not a program can listen on a port, right? (and all the other
fun things).

If so then all you'd have to do is deny external access to port 2525
and only permit mailuser to listen etc on it and you're set.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

