Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHMCU7>; Sun, 12 Aug 2001 22:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269731AbRHMCUj>; Sun, 12 Aug 2001 22:20:39 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:9736 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S269728AbRHMCUj>; Sun, 12 Aug 2001 22:20:39 -0400
Date: Mon, 13 Aug 2001 02:20:50 +0000 (GMT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Frank Jacobberger <f1j@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UDMA 5
In-Reply-To: <3B77361B.6020302@xmission.com>
Message-ID: <Pine.LNX.4.10.10108130218380.7720-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where is kernel development with respect to ATA 100
> IDE drives?

they have worked fine for a long time.

> The only param idebus=xx takes is 66... are
> there plans to go to 100?

that's not what the switch means.  instead, it gives the base clock
for the controller, which should normally be 33.  it does *not* tell 
the controller to run the *channel* at 100; in fact, idebus=66
should result in *halving* the performance of your disks...

