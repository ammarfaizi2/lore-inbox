Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272156AbTGYPhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272158AbTGYPhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:37:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:27010 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272156AbTGYPga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:36:30 -0400
Date: Fri, 25 Jul 2003 17:01:40 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251601.h6PG1etD001373@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, ndiamond@wta.att.ne.jp
Subject: Re: Japanese keyboards broken in 2.6
Cc: cs@tequila.co.jp, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > setkeycodes 0x6a 124 1>&2 in your rc.local, local.start or whatever.
> > > works fine for me for alle 2.5x kernels
> > 
> > There must be a ton of odd stuff going on.  "showkey" used to say that the
> > scan code is 0x7d not 0x6a, but now it displays weird stuff.  As previously
> > mentioned, "getkeycodes" displays a table which seems far removed from
> > reality.  But the patch from junkio@cox.net worked (but "showkey" and
> > "getkeycodes" still produce weird output).
>
> Yes.
>
> I am a little bit unhappy with the state of the kbd code
> (but have not yet decided whether I want to attempt to fix something).
>
> One aspect of the matter is that raw mode no longer is raw.
> The keyboard sends codes and the input layer translates that into
> the codes the input layer thinks the keyboard should have sent.
> Then, when one wants the raw codes, a reverse translation is used,
> but since the mapping is not one-to-one the reverse translation
> does not produce what the keyboard sent to start with.

Doesn't AT-set3 usually have a closer one to one mapping of keys?

John.
