Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289174AbSA1PiI>; Mon, 28 Jan 2002 10:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289100AbSA1Phs>; Mon, 28 Jan 2002 10:37:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26372 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281214AbSA1Phq>; Mon, 28 Jan 2002 10:37:46 -0500
Message-ID: <3C55703C.30306@zytor.com>
Date: Mon, 28 Jan 2002 07:37:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C542FE6.7C56D6BD@mandrakesoft.com> <3C5439C1.6000305@evision-ventures.com> <3C543E86.7F0FA37A@gmx.net> <a31q91$upd$1@nell.transmeta.com> <3C553EE3.4060202@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> 
> Well boys, I know about the ifconfig command, and I just don't see 
> anything special there.
> In esp. no collision indications. I would rather suspect, that there are 
> maybe some IRQ sharing
> problems with the driver, since this got changed as well. However I 
> simple just didn't
> have the time to narrow it down to this. (In esp. doing a recompile with 
> just the blah_irq -> blash_irqsave
> changes enabled.
> 


Autoconfigure screwing up usually (in my experience) doesn't indicate 
collisions.  If you have 100Mbit and FD lights on your card, they would 
typically be going on and off, though.

	-hpa


