Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266658AbUGLMB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUGLMB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUGLMB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:01:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:40681 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266658AbUGLMB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:01:26 -0400
Date: Mon, 12 Jul 2004 14:00:00 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roger Luethi <rl@hellgate.ch>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine breaks with recent Linus kernels : probe of 0000:00:09.0
 failed with error -5
In-Reply-To: <20040712115408.GA31854@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.56.0407121357320.24721@jjulnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk>
 <20040712080933.GA9221@k3.hellgate.ch> <Pine.LNX.4.56.0407121317130.24721@jjulnx.backbone.dif.dk>
 <20040712115408.GA31854@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Roger Luethi wrote:

> On Mon, 12 Jul 2004 13:27:17 +0200, Jesper Juhl wrote:
> > Making this change to 2.6.8-rc1 has no effect for me :
> >
> [...]
> >
> > But, copying the driver from 2.6.7-mm7 to 2.6.8-rc1 works like a charm.
> Thanks. <sigh> Not knowing the cause, especially considering that the
> bug mysteriously vanished on my box makes me nervous. That there is a
> serious problem in a mainline -rc doubly so.
> I'll try to reproduce on a different box as soon as I get around to
> it, hopefully tonight. If you could help tracking down the culprit
> in via-rhine that would be great. Basically, the differences between
> those drivers are 9 experimental patches I posted on June 15 on netdev
> (attached).

Sure thing, I'll start testing those and see if I can track it down. I'll
get back to you as soon as possible - I might not get the time to test it
completely today, but at least tomorrow I should have the time for it.

--
Jesper Juhl <juhl-lkml@dif.dk>
