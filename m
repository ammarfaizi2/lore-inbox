Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265650AbUEZQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbUEZQln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbUEZQln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:41:43 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:44233 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265650AbUEZQll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:41:41 -0400
Date: Wed, 26 May 2004 18:41:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526164129.GA31758@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040526130500.GB18028@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 15:05:00 +0200, Arjan van de Ven wrote:
> 
> You used the word "Never" and now you go away from it.... It wasn't Never,
> and it will never be never if you want to include random binary only
> modules. However in 2.4 for all intents and pruposes there was 4Kb already,
> and now there still is, for user context. Because those interrupts DO
> happen. NVidia was a walking timebomb, and with one function using 4Kb
> that's an obvious Needs-Fix case. The kernel had a few of those in rare
> drivers, most of which have been fixed by now. It'll never be never, but it
> never was never either.

In a way, you are right.  nVidia was and is a walking timebomb and
making bugs more likely to happen is a good thing in general.  Except
that this bug can eat filesystems, so making it more likely will cause
more filesystems to be eaten.

Anyway, whether we go for 4k in 2.6 or not, we should do our best to
fix bad code and I will go looking for some more so others can go and
fix some more.  There's still enough horror in mainline for more than
one amusement park, we just haven't found it yet.

Jörn

-- 
All art is but imitation of nature.
-- Lucius Annaeus Seneca
