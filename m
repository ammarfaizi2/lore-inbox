Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSK2IIO>; Fri, 29 Nov 2002 03:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbSK2IIO>; Fri, 29 Nov 2002 03:08:14 -0500
Received: from khms.westfalen.de ([62.153.201.243]:16106 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S266976AbSK2IIN>; Fri, 29 Nov 2002 03:08:13 -0500
Date: 29 Nov 2002 08:55:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8anf-3Gmw-B@khms.westfalen.de>
In-Reply-To: <as6aks$amj$1@ncc1701.cistron.net>
Subject: Re: connectivity to bkbits.net?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <as6aks$amj$1@ncc1701.cistron.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miquels@cistron.nl (Miquel van Smoorenburg)  wrote on 28.11.02 in <as6aks$amj$1@ncc1701.cistron.net>:

> In article <20021128211347.D27234@flint.arm.linux.org.uk>,
> Russell King  <rmk@arm.linux.org.uk> wrote:
> >On Thu, Nov 28, 2002 at 06:53:00PM +0200, Kai Henningsen wrote:
> >> >From two or three traceroutes, that problem seems to be at the SGI end.
> >> >I
> >> can't get to them either (nothing after the same IP as for you, at hop
> >> #17, some place at Genuity), but you are practically next door.
> >
> >Lesson #1 of firewalling: drop everything.
> >Lesson #2 of firewalling: only accept what you absolutely have to.
>
> Lesson#3 of firewalling: due to #1 and #2 most admins block
> ICMP_UNREACH_NEEDFRAG as well (ICMP == ping == bad) breaking
> path MTUd. http://alive.znep.com/~marcs/mtu/

Lesson #4 of firewalling: a friendly firewall will (unless there are  
*specific* reasons to do otherwise) allow for ICMP_UNREACH_NEEDFRAG (and  
some similar things), ping, and traceroute. That's how I usually set them  
up. (ping == good)

MfG Kai
