Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSJITXE>; Wed, 9 Oct 2002 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSJITXE>; Wed, 9 Oct 2002 15:23:04 -0400
Received: from [216.40.201.6] ([216.40.201.6]:52745 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S261851AbSJITXE>; Wed, 9 Oct 2002 15:23:04 -0400
Date: Wed, 9 Oct 2002 15:58:19 -0300
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps forever)
Message-ID: <20021009185819.GN335@cathedrallabs.org>
References: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem with a ALi M5229 but only with dma enabled. if it
suspends with dma enabled, when it resumes I got dma timeouts until it give
up and disable dma. after this I can't enable dma anymore. I guess
implementing resume() of alim15x3 to reconfigure chipset will solve this.
any sugestions/comments?

> I have problem with resume from suspend on IBM T22 with kernel 2.4.19
> patched with rmap-14a and usagi-20020916. Actually the problem is that OS
> resume well from suspend (it prints some messages to console for example
> from FW droping some packets), but harddisc is still sleeping and never
> wake up...

-- 
aris
