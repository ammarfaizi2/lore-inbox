Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHRVr4>; Sat, 18 Aug 2001 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbRHRVrq>; Sat, 18 Aug 2001 17:47:46 -0400
Received: from u-170-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.170]:24706
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S268145AbRHRVri>; Sat, 18 Aug 2001 17:47:38 -0400
Date: Sat, 18 Aug 2001 23:45:11 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: David Ford <david@blue-labs.org>
Cc: Justin Guyett <justin@soze.net>, Jim Roland <jroland@roland.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Aliases
Message-ID: <20010818234511.A17775@bacchus.dhis.org>
In-Reply-To: <00df01c127a8$c354ad20$bb1cfa18@JimWS> <Pine.LNX.4.33.0108180245070.27721-100000@kobayashi.soze.net> <20010818143232.A11687@bacchus.dhis.org> <3B7EC12B.4010204@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7EC12B.4010204@blue-labs.org>; from david@blue-labs.org on Sat, Aug 18, 2001 at 03:25:31PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 03:25:31PM -0400, David Ford wrote:

> >For various reasons interfaces aliases are deprecated.  The recommended
> >way of doing things these days is just adding more addresses to an
> >interface with the ip(8) program from the iproute package.  It works like:
> >
> >  ip addr add 192.168.2.0/24 broadcast 192.168.2.255 scope host dev eth0
> 
> You can shorten this to:
> 
>     ip a a 192.168.2.0/24 brd + dev eth0
> 
> ..and leaving the scope global [by default] which makes it fully reachable.

I did not mean to reproduce the whole over 50 pages of docs documentation
in my posting.

  Ralf
