Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbTGTMUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267020AbTGTMUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:20:51 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:41709 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267004AbTGTMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:20:50 -0400
Date: Sun, 20 Jul 2003 14:35:49 +0200
From: Kurt Roeckx <Q@ping.be>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sb16 kernel parameters.
Message-ID: <20030720123549.GA167@ping.be>
References: <20030717220915.GA5046@ping.be> <3F1730C9.4020300@sbcglobal.net> <20030718190054.GA152@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718190054.GA152@ping.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 09:00:55PM +0200, Kurt Roeckx wrote:
> 
> I tried using things like:
> snd-sb16=1,0,card1,0,0x220,-1,-1,7,1,5,0
> 
> But when booting the kernel with that parameter, just after
> "booting the kernel", it reboots.  Without that parameter it
> boots normally.

I just tried the OSS version instead.

During boot I now always get:
sb: Init: Starting Probe...
sb: Error: At least io, irq, and dma must be set for legacy cards.
sb: Init: Done

I tried using the parameters sb=0x220,7,1,5 and
snd-sb16=1,0,card1,0,0x220,-1,-1,7,1,5,0
but neither seems to work.


Kurt

