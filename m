Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752751AbWKCMVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbWKCMVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbWKCMVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:21:22 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:48536 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1752751AbWKCMVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:21:21 -0500
Date: Fri, 3 Nov 2006 13:21:26 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061103122126.GC11947@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <20061103101901.GA11947@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 November 2006 12:56:36 +0100, Mikulas Patocka wrote:
> >
> >I am fully aware the counters are effectively 48-bit.  If they were
> >just 32-bit, you would likely have hit the problem yourself already.
> 
> Given the seek time 0.01s, 31-bit value would last for minimum time of 248 
> days when doing only syncs and nothing else. 47-bit value will last for 
> reasonably long.

So you can at most do one transaction per drive seek?  That would
definitely solve the overflow case, but hardly sounds like a
high-performance filesystem. :)

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
