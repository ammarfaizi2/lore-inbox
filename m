Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275200AbTHMOvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275201AbTHMOuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:50:55 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3079 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275200AbTHMOus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:50:48 -0400
Date: Wed, 13 Aug 2003 10:42:31 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries.Brouwer@cwi.nl
cc: fvw@var.cx, linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
In-Reply-To: <UTC200307310941.h6V9fP204094.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.3.96.1030813103103.11041A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 Andries.Brouwer@cwi.nl wrote:

> > First of all, in util-linux 2.12 the keybits option is gone
> > I wanted to have losetup/mount hash the passphrase
> 
> The patches I got were maximal, too much junk.
> So I went for a minimal version instead.
> 
> It is usable (when the kernel part is stable, which it isn't today)
> but mount/losetup may well acquire a few options before it is
> conveniently usable.

I'm not sure what value of stable you want, I've been using 2.6.0-test1
(ac?) with crypto since it came out. Clearly there are a lot of things
missing before 2.6 is ready for general use, but it sure is nice to have
that filesystem protected. The crypto seems stable, as long as that's the
main thing you do with the box.

I hope we can get the control of key length back, while I doubt that
anyone who actually could break the default is going to be involved in
anything I do, I'd like to see it for future applications.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

