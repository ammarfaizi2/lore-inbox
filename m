Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbREOIJO>; Tue, 15 May 2001 04:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262671AbREOIJE>; Tue, 15 May 2001 04:09:04 -0400
Received: from popeye.ipv6.univ-nantes.fr ([193.52.101.20]:516 "HELO
	popeye.ipv6.univ-nantes.fr") by vger.kernel.org with SMTP
	id <S262670AbREOIIw>; Tue, 15 May 2001 04:08:52 -0400
Subject: Re: PATCH 2.4.4.ac9: Tulip net driver fixes
From: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3B002595.76399CE4@mandrakesoft.com>
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com>
	<20010514112216.A25436@lucon.org> <20010514112407.E781@suse.com> 
	<3B002595.76399CE4@mandrakesoft.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10+cvs.2001.04.18.22.02 (Preview Release)
Date: 15 May 2001 10:08:50 +0200
Message-Id: <989914130.25256.1.camel@olive>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14 May 2001 14:36:05 -0400, Jeff Garzik a écrit :
> Mads Martin Jørgensen wrote:

> Attached is a patch against 2.4.4-ac9 which includes the changes found
> in tulip-devel 1.1.6...   (tulip-devel is sort of a misnomer; right now
> it's really just a staging and testing point for fixes which go straight
> into the tulip-stable series)
> 
> I just checked against ac9 and it applies cleanly here.


Still the same issue here : On a quad port card, if only 1 port is up,
all is fine. This can be eth0, eth1, eth2 or eth3, it doesn't matter.

As soon as more than 1 port is up, the machine freeze. no oops, 
not event CTRL-Scrollback, nothing.

As the use I made of the 4 port eth is bridging, you can imagine
the freeze appears very shortly after boot ;-) 

Anyway. using the de4x5 driver for now.

Yann.

-- 
\|/ ____ \|/ Fac. des sciences de Nantes-Linux-Python-IPv6-ATM-BONOM....
"@'/ ,. \@"  Tel :(+33) [0]251125865(AM)[0]251125857(PM)[0]251125868(Fax)
/_| \__/ |_\ Yann.Dupont@sciences.univ-nantes.fr
   \__U_/    http://www.unantes.univ-nantes.fr/~dupont

