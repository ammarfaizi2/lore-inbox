Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbRHAEmq>; Wed, 1 Aug 2001 00:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269636AbRHAEmh>; Wed, 1 Aug 2001 00:42:37 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:21007 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266718AbRHAEmY>;
	Wed, 1 Aug 2001 00:42:24 -0400
From: Andrew Tridgell <tridge@valinux.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107312326080.8866-100000@freak.distro.conectiva>
	(message from Marcelo Tosatti on Tue, 31 Jul 2001 23:26:59 -0300
	(BRT))
Subject: Re: 2.4.8preX VM problems
Reply-To: tridge@valinux.com
In-Reply-To: <Pine.LNX.4.21.0107312326080.8866-100000@freak.distro.conectiva>
Message-Id: <20010801043749.3AE4C44A4@lists.samba.org>
Date: Tue, 31 Jul 2001 21:37:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Marcelo wrote:
> Can you reproduce the problem with 2.4.7 ? 

no, it started with 2.4.8pre1. I am currently narrowing it down by
reverting pieces of that patch and I have successfully narrowed it
down to the changes in mm/vmscan.c. I have a 2.4.8pre3 kernel with a
hacked version of the 2.4.7 vmscan.c that doesn't show the
problem. I'll try to narrow it down a bit more this afternoon.

Cheers, Tridge
