Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSKCU25>; Sun, 3 Nov 2002 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSKCU25>; Sun, 3 Nov 2002 15:28:57 -0500
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:41124 "EHLO
	ellpspace.math.ualberta.ca") by vger.kernel.org with ESMTP
	id <S262500AbSKCU25>; Sun, 3 Nov 2002 15:28:57 -0500
Date: Sun, 3 Nov 2002 13:35:28 -0700
From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103133528.A14177@ellpspace.math.ualberta.ca>
Reply-To: michal@harddata.com
References: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu> <1036307763.31699.214.camel@thud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036307763.31699.214.camel@thud>; from dax@gurulabs.com on Sun, Nov 03, 2002 at 12:16:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:16:02AM -0700, Dax Kelson wrote:
> 
> Speaking of user 'nobody', modern best practices (and shipped vendor
> configuration) strongly discourages lumping everything under 'nobody'.
> 
> Each app should run in its own security context by itself.  That is why
> I have all the following users in my /etc/passwd:
> 
> apache nscd squid xfs ident rpc pcap nfsnobody radvd gdm named ntp

As a side issue each of these "users", or most of them, has likely also
its own group and one needs also few groups for other purposes.  Seems
like the next potential point to bump into a numbers of groups barrier
although probably most of these does not need to be shared.  Still if
this will become a part of a widely used security mechanisms there could
be extra demands on memberships.

  Michal
