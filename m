Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTGBJrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTGBJrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:47:21 -0400
Received: from [62.151.11.132] ([62.151.11.132]:32488 "EHLO smtp2.yaonline.es")
	by vger.kernel.org with ESMTP id S264873AbTGBJrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:47:15 -0400
Date: Wed, 2 Jul 2003 12:09:04 +0200
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Message-Id: <20030702120904.0cb7e6a6.ktech@wanadoo.es>
In-Reply-To: <200307021953.59294.kernel@kolivas.org>
References: <20030702111720.084843e9.ktech@wanadoo.es>
	<200307021953.59294.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003 19:53:59 +1000
Con Kolivas <kernel@kolivas.org> wrote:

> On Wed, 2 Jul 2003 19:17, Luis Miguel Garcia wrote:
> > Con,
> >
> > I have not tested the latest patch from you, but I'm actually running with
> > the one you made public yesterday and it behaves VERY strangely. Sometime,
> > with only XMMS and aMSN (an Instant Messaging app), if I pick an xterm and
> > move it around the screen very fast, xmms stops clearly until I stop doing
> > bad things with the window.
> 
> Yes indeed the old one would do that. The time constant was 10 seconds so an 
> app would have to be running for up to 50 seconds before it was balanced. 
> This new one fixes that by applying a non linear boost with time.
> 
> > Other times, even when I'm compiling something, I can do that with the
> > windows and XMMS doesn't stop at all.
> 
> After a minute of running xmms I'd say.
> 
> > Very strange, not to?
> 
> Not at all :)

Yes, it seems that this explanation is totally ok. I'm going to test newst patch and say you something

Thanks!

Luis Miguel Garcia
