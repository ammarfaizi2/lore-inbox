Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUHVXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUHVXmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbUHVXmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:42:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:40134 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266878AbUHVXmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:42:18 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Trivial IPv6-for-Fedora HOWTO
Organization: Deban GNU/Linux Homesite
In-Reply-To: <4129236E.9020205@pobox.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bz1ya-0006Vi-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 23 Aug 2004 01:42:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4129236E.9020205@pobox.com> you wrote:
> If you have an iptables ipv4 firewall, you'll want to
> 
> F1) allow ipv6 tunnelled packets to pass through to ip6tables, by 
> allowing protocol 41
> 
> iptables -A block -p 41 -j ACCEPT
> ("block" is a custom chain on my firewall)
> 
> F2) duplicate your ipv4 firewall rules for ipv6, using ip6tables.  Some 
> things, like masquerade, are not applicable to ipv6.

Note that you have to terminate the tunnel on your firewall in order to
filter the encapsulated ipv6. This is important, since letting tunnel
packets pass your firewall is a major security problem, otherwise.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
