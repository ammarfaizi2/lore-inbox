Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbRGWS1X>; Mon, 23 Jul 2001 14:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268327AbRGWS1N>; Mon, 23 Jul 2001 14:27:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16486 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268323AbRGWS1F>; Mon, 23 Jul 2001 14:27:05 -0400
Date: Mon, 23 Jul 2001 20:27:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723202734.C16919@athlon.random>
In-Reply-To: <20010723195055.A16919@athlon.random> <Pine.LNX.4.33.0107231103570.13272-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107231103570.13272-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jul 23, 2001 at 11:11:25AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 11:11:25AM -0700, Linus Torvalds wrote:
> Now, the change of algorithm might be something like
> 
> 	/*
> 	 * We need to get _one_ value here, because our
> 	 * state machine ....
> 	 */

gcc can assume 'state' stays constant in memory not just during the
'case'.

> The C standard doesn't say crap about volatile. It leaves it up to the
> compiler to do something about it.

The C folks definitely say it is a kernel bug if you don't apply my
patch and I agree with them.  Ask Jan.

Andrea
