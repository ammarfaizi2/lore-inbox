Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJATWi>; Tue, 1 Oct 2002 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJATWi>; Tue, 1 Oct 2002 15:22:38 -0400
Received: from pasky.ji.cz ([62.44.12.54]:19963 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262128AbSJATWh>;
	Tue, 1 Oct 2002 15:22:37 -0400
Date: Tue, 1 Oct 2002 21:28:03 +0200
From: Petr Baudis <pasky@pasky.ji.cz>
To: Jochen Friedrich <jochen@scram.de>
Cc: Andi Kleen <ak@muc.de>, jbradford@dial.pipex.com,
       linux-kernel@vger.kernel.org, debian-ipv6@debian.org
Subject: IPv6 stability (success story ;)
Message-ID: <20021001192803.GR6548@pasky.ji.cz>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Andi Kleen <ak@muc.de>, jbradford@dial.pipex.com,
	linux-kernel@vger.kernel.org, debian-ipv6@debian.org
References: <m3k7l47qsv.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209291914220.18326-100000@alpha.bocc.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Sep 29, 2002 at 07:26:37PM CEST, I got a letter,
where Jochen Friedrich <jochen@scram.de> told me, that...
> Hi Andi,
> 
> > Actually current IPv6 is stable and has been for a long time, it's just not
> > completely standards compliant (but still quite usable for a lot of people)
> 
> For end systems (no router) with static IPv6 definitions this seems to be
> true. However, for machines which use autoconfiguration (stateless as
> there isn't a usable IPv6 capable DHCP server AFAIK) or act as routers,
> the current state of the implementation of the default route can best be
> described as buggy. (Autoconfigured machines seem to loose their default
> route after some time, e.g.).

Well, I maintain Point of Presence for XS26 at Prague running on linux
(2.4.19), and it works with almost no problems routing about 20 kilobytes per
second through about 520 interfaces (tunnels) and with routing table consisting
of cca 2100 entries (there's zebra, ospf6d and bgpd running there ;). The only
one real problem we had was neighbour discovery bug up to 2.4.18 which was
fixed along the way to 2.4.19. There are no crashes, no routing instabilities,
we are absolutely happy with linux there ;-) (in fact, we have frequently much
more problems with the *BSDs running at some other PoPs).

Oh, of course, I must thank Alexey a lot for providing excellent support for us
:).

-- 
 
				Petr "Pasky" Baudis
 
* ELinks maintainer                * IPv6 guy (XS26 co-coordinator)
* IRCnet operator                  * FreeCiv AI occassional hacker
.
<Beeth> Girls are like internet domain names, the ones I like are already taken.
<honx> Well, you can still get one from a strange country :-P
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
