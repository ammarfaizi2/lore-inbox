Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271797AbTGRSqC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271794AbTGRSqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:46:02 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:19867 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S271797AbTGRSqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:46:00 -0400
Date: Fri, 18 Jul 2003 21:00:55 +0200
From: Kurt Roeckx <Q@ping.be>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sb16 kernel parameters.
Message-ID: <20030718190054.GA152@ping.be>
References: <20030717220915.GA5046@ping.be> <3F1730C9.4020300@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1730C9.4020300@sbcglobal.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 06:27:05PM -0500, Wes Janzen wrote:
> You'll need to use the kernel parameter 
> (Documentation/kernel-parameters.txt) snd-sb16 .
> 
> Looking at the docs in the Documentation/sound/alsa directory:

I did look at both, the alsa documentation wasn't that clear.

It doesn't say what fm_port is, in what order the parameters are.

> And at the end of the sb16.c file I found:
> 
> #ifndef MODULE
> 
> /* format is: snd-sb16=enable,index,id,isapnp,
>                       port,mpu_port,fm_port,
>                       irq,dma8,dma16,
>                       mic_agc,csp,
>                       [awe_port,seq_ports]
> 
> Which is probably what format you'll need to use but I don't know much 
> about drivers...;-)

Ah, didn't find that.

I tried using things like:
snd-sb16=1,0,card1,0,0x220,-1,-1,7,1,5,0

But when booting the kernel with that parameter, just after
"booting the kernel", it reboots.  Without that parameter it
boots normally.


Kurt

