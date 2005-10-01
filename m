Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVJAR6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJAR6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 13:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJAR6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 13:58:33 -0400
Received: from mail.collax.com ([213.164.67.137]:14739 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750724AbVJAR6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 13:58:33 -0400
Message-ID: <433ECE42.2070400@trash.net>
Date: Sat, 01 Oct 2005 19:58:26 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.13-rc2+ - problem with DHCP
References: <433EBBEC.4050203@gorzow.mm.pl>
In-Reply-To: <433EBBEC.4050203@gorzow.mm.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw Szkodzinski wrote:
> These kernels just do not get the IP from DHCP.
> I think the problem is caused by Mercurial tree changeset 8919 (more
> likely) or 8918.
> 
> At least the last tested working one is:
> changeset:   8917:07c96175a75e
> user:        Patrick McHardy <kaber@trash.net>
> date:        Tue Sep 13 21:00:14 2005 +0011
> summary:     [NETFILTER]: Simplify netbios helper
> 
> Probably the culprit is:
> changeset:   8919:61b9c3185973
> user:        Patrick McHardy <kaber@trash.net>
> date:        Tue Sep 13 21:00:55 2005 +0011
> summary:     [NETFILTER]: Fix DHCP + MASQUERADE problem

Are you sure? The patch was supposed to fix problems with DHCP clients
using regular UDP sockets for sending DHCP requests. Which client are
you using?
