Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRKXTkb>; Sat, 24 Nov 2001 14:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKXTkX>; Sat, 24 Nov 2001 14:40:23 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:1040 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S279418AbRKXTjp>; Sat, 24 Nov 2001 14:39:45 -0500
Date: Sat, 24 Nov 2001 14:39:44 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
In-Reply-To: <3BFFE8A2.1010708@rueb.com>
Message-ID: <Pine.LNX.4.10.10111241402420.3696-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So what are the implications here for journalling?  Do I have to turn 
> off caching and suffer a huge performance hit?

why does everyone get freaked out about disk caches?  afaikt, 
there's only an O(50ms) window at each catastrophic power failure:
trivial for any reasonable rate of failures...

