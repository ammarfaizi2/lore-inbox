Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHFONB>; Mon, 6 Aug 2001 10:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRHFOMv>; Mon, 6 Aug 2001 10:12:51 -0400
Received: from zero.aec.at ([195.3.98.22]:57098 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S268598AbRHFOMb>;
	Mon, 6 Aug 2001 10:12:31 -0400
To: root@iligan.com (rtviado)
cc: linux-kernel@vger.kernel.org
Subject: Re: load balancing on more than 1 default routes
In-Reply-To: <3B6A2B9A.6E88D0E8@theOffice.net> <Pine.LNX.4.33.0108031752040.907-100000@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: 06 Aug 2001 16:12:40 +0200
In-Reply-To: root@iligan.com's message of "Fri, 3 Aug 2001 09:56:23 +0000 (UTC)"
Message-ID: <k2bslte0pz.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0108031752040.907-100000@localhost.localdomain>,
root@iligan.com (rtviado) writes:
> Hello,

> 	I just want to ask if there is a facility in the kernel that load
> balance to different default routes, since i'm using this routes for
> uplink purposes only (my downlink is via satellite, it doesn't matter
> where i send my packets uplink as long as it reaches the internet
> backbone).

2.2+ support multipath routing with load balancing per route. You can configure
it by specifying multiple nexthops with iproute2.

-Andi

