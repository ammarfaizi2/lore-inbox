Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTGBJuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTGBJug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:50:36 -0400
Received: from [62.151.11.132] ([62.151.11.132]:17641 "EHLO smtp2.yaonline.es")
	by vger.kernel.org with ESMTP id S264913AbTGBJuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:50:25 -0400
Date: Wed, 2 Jul 2003 12:12:14 +0200
From: Luis Miguel Garcia <ktech@wanadoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Message-Id: <20030702121214.5d741366.ktech@wanadoo.es>
In-Reply-To: <200307021953.59294.kernel@kolivas.org>
References: <20030702111720.084843e9.ktech@wanadoo.es>
	<200307021953.59294.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con, must I use granularity with the latest patch? I'm actually compiling with it.

Thanks!


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
> 
> > When I have time, I'll test you patch from today.
> 
> Great.
> 
> Con
> 


-- 
=============================================================
Luis Miguel Garcia Mancebo
Ingenieria Tecnica en Informatica de Gestion
Universidad de Deusto / University of Deusto
Bilbao / Spain
=============================================================
