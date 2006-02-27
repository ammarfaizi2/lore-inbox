Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWB0Sco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWB0Sco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWB0Sco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:32:44 -0500
Received: from mail.linicks.net ([217.204.244.146]:53916 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751446AbWB0Sco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:32:44 -0500
From: Nick Warne <nick@linicks.net>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Date: Mon, 27 Feb 2006 18:32:22 +0000
User-Agent: KMail/1.9.1
Cc: Henrik Persson <root@fulhack.info>, Robert Hancock <hancockr@shaw.ca>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200602261308.47513.nick@linicks.net> <200602262110.55324.nick@linicks.net> <4402FF89.4070009@rtr.ca>
In-Reply-To: <4402FF89.4070009@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271832.22186.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 13:32, Mark Lord wrote:
> Nick Warne wrote:
> > As a user we know if DMA is OK on a ide device, right?  Then let user
> > have option to set it permanent, else carry on as the code does now when
> > idex needs a reset.
>
> Does "hdparm -K1 /dev/hda" solve the problem?  That's what that option was
> for originally, but I don't know if the IDE driver still uses it correctly.

Strangely, I was reading up on this at work today, and it does indeed look 
like what is required (although my man page refers to -k for options -dmu ) - 
so I set both -k1 -K1 options.

Now to wait and see the drive produce the error.

Thanks for help Mark,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
