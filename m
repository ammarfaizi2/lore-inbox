Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbRDXO5j>; Tue, 24 Apr 2001 10:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135675AbRDXO5a>; Tue, 24 Apr 2001 10:57:30 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:41622 "HELO
	vega.digitel2002.hu") by vger.kernel.org with SMTP
	id <S135673AbRDXO4o>; Tue, 24 Apr 2001 10:56:44 -0400
Date: Tue, 24 Apr 2001 16:56:32 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Pjotr Kourzanoff <pjotr@suselinux.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010424165632.A7652@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20010424163009.A7197@vega.digitel2002.hu> <Pine.LNX.4.31.0104241643400.17653-100000@zeus.suselinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.31.0104241643400.17653-100000@zeus.suselinux.hu>; from pjotr@suselinux.hu on Tue, Apr 24, 2001 at 04:49:57PM +0200
X-Operating-System: vega Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 04:49:57PM +0200, Pjotr Kourzanoff wrote:
> On Tue, 24 Apr 2001, [iso-8859-2] Gábor Lénárt wrote:
> >
> > Or even without xinetd. Just use local port forwarding eg 2525 -> 25, and
> 
>   This is more like 25 -> 2525 :-)

OK, that was a hard night for me, I need some sleeeeeep :)

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

Yes, you're right. But this is a mail server without any user on it
(even users are authenticated from LDAP).

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
