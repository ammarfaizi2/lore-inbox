Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319300AbSH2SnT>; Thu, 29 Aug 2002 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319301AbSH2SnT>; Thu, 29 Aug 2002 14:43:19 -0400
Received: from p50839D4A.dip.t-dialin.net ([80.131.157.74]:6918 "EHLO
	calista.inka.de") by vger.kernel.org with ESMTP id <S319300AbSH2SnS>;
	Thu, 29 Aug 2002 14:43:18 -0400
Date: Thu, 29 Aug 2002 20:47:39 +0200
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020829184739.GA8552@lina.inka.de>
References: <20020827160722.GA13412@alcove.wittsend.com> <E17k8H8-0003Le-00@sites.inka.de> <20020829020501.GA21384@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020829020501.GA21384@alcove.wittsend.com>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 10:05:01PM -0400, Michael H. Warfield wrote:
> 	This all does raise another question, though.  Why don't link local
> addresses work...  Link local scoped addresses should be valid and work
> between hosts on the same "link" or subnet (colision zone, flat network,
> whatever you want to call it).

they work only if you specify a device. Which is logical if you have more
than one device, it is less so, if you have only one.

> ] [root@alcove mhw]# ping6 -c 2 fe80::8200:280:c8ff:fecf:bf06
> ] connect: Invalid argument

you need to give -I eth1 like it is decribed in the ping6 manpage:

     -I interface address
              Set source address to specified interface  address.  Argu­
              ment  may  be  numeric  IP address or name of device. When
              pinging IPv6 link-local address this option is required.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
