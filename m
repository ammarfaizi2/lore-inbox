Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269619AbRHHXTF>; Wed, 8 Aug 2001 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269630AbRHHXSy>; Wed, 8 Aug 2001 19:18:54 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:1028 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S269619AbRHHXSf>; Wed, 8 Aug 2001 19:18:35 -0400
Date: Wed, 8 Aug 2001 23:17:55 +0000 (GMT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108081721001.13989-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10108082314410.10284-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your change in pre7 makes zone_inactive_shortage() not return the shortage
> size, which is needed by refill_inactive().

similar for zone_free_shortage used in total_free_shortage I think.

