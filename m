Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRDGPwl>; Sat, 7 Apr 2001 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRDGPwW>; Sat, 7 Apr 2001 11:52:22 -0400
Received: from TK152095.tuwien.teleweb.at ([195.34.152.95]:4094 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S132672AbRDGPwN>;
	Sat, 7 Apr 2001 11:52:13 -0400
Date: Sat, 7 Apr 2001 17:52:17 +0200
From: Armin Obersteiner <armin@xos.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19 smp interrupt problems?
Message-ID: <20010407175217.A9788@elch.elche>
In-Reply-To: <3ACEF337.F3300093@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3ACEF337.F3300093@colorfullife.com>; from manfred@colorfullife.com on Sat, Apr 07, 2001 at 01:00:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

thanx, worked. the old driver should be default for 8129 (selecting it for 8139 
should be deprecated) and the new one for 8139 ...
 
> > everything seems to work fine. are these interrupt problems "bad" or merely 
> > indicators of a high load. can/should one get rid of them? 
> >
> Could you try the 8139too driver?
> 
> It's a bug in the rtl8139 driver, and under really high load it can
> cause crashes.

MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
