Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276686AbRJGUnr>; Sun, 7 Oct 2001 16:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276673AbRJGUn1>; Sun, 7 Oct 2001 16:43:27 -0400
Received: from [194.213.32.141] ([194.213.32.141]:38016 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276686AbRJGUnP>;
	Sun, 7 Oct 2001 16:43:15 -0400
Message-ID: <20011007093539.C454@bug.ucw.cz>
Date: Sun, 7 Oct 2001 09:35:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Rik van Riel <riel@conectiva.com.br>
Cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110061357560.12110-200000@imladris.rielhome.conectiva> <Pine.LNX.3.96.1011006194028.5632A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.3.96.1011006194028.5632A-100000@artax.karlin.mff.cuni.cz>; from Mikulas Patocka on Sat, Oct 06, 2001 at 07:48:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So what are you going to do when your 64MB of vmalloc space
> > runs out ?
> 
> Make larger vmalloc space :-) Virtual memory costs very little.
> Besides 64M / 8k = 8192 - so it runs out at 8192 processes.

Hard to do of machine with 1GB ram... There, virtual memory costs
*very* much.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
