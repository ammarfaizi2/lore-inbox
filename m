Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbRFLSwy>; Tue, 12 Jun 2001 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLSwo>; Tue, 12 Jun 2001 14:52:44 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:9326 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263079AbRFLSw2>; Tue, 12 Jun 2001 14:52:28 -0400
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
From: Florin Andrei <florin@sgi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <01061109303910.16602@ycn013>
In-Reply-To: <01061109303910.16602@ycn013>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 12 Jun 2001 11:51:47 -0700
Message-Id: <992371907.26356.3.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jun 2001 13:00:41 -0500, John Madden wrote:
> 
> kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!

I have the same problem, since a long time, with various 2.2 and 2.4
kernels running on a i815 motherboard, with on-board eepro100 net card.

> The only solution I've found that works is to reboot, and since this is

For me, it's enough to "ifconfig down" then "ifconfig up" the interface.

I will probably buy another network card, since changing the OS is not
an option, and Linux seems to not like eepro100 that much... :-/

-- 
Florin Andrei

