Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265010AbUFAMVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbUFAMVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAMVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:21:21 -0400
Received: from gprs214-199.eurotel.cz ([160.218.214.199]:10880 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265019AbUFAMUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:20:25 -0400
Date: Tue, 1 Jun 2004 14:20:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601122013.GA10233@elf.ucw.cz>
References: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601060205.GE15492@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So effectively, it comes down to the recursive paths.  Unless someone
> > comes up with a semantical parser that can figure out the maximum
> > number of iterations, we have to look at them manually.
> 
> Linus, Andrew, would you accept patches like the one below?  With such
> information and assuming that the comments will get maintained, it's
> relatively simple to unroll recursions and measure stack comsumption
> more accurately.

Perhaps some other format of comment should be introduced? Will not
this interfere with linuxdoc?
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
