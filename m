Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbTLHCh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbTLHCh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:37:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:50568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265302AbTLHChz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:37:55 -0500
Date: Sun, 7 Dec 2003 18:37:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Cormack <gvcormac@uwaterloo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.test11 bug
In-Reply-To: <20031208022427.GA12859@cormack.uwaterloo.ca>
Message-ID: <Pine.LNX.4.58.0312071835020.10665@home.osdl.org>
References: <20031208022427.GA12859@cormack.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Dec 2003, Gordon Cormack wrote:
>
> I have read the FAQ but I'm confused about how to report a 2.6
> kernel bug, or who to report it to.

This is good.

> Here it is in a nutshell.

And we want some more information on what kind of load/machine/config this
is. However, I'm guessing from the report..

> Dec  6 13:16:01 flax20 kernel: Bad page state at free_hot_cold_page

..that this might be running XFS? We've had this report from XFS users
before.

But if it isn't using XFS, holler _loudly_, and please do include more
information about what configuration (both hardware and kernel config) the
machine has.

> As an aside, all versions of the 2.4 kernel are brought to their knees
> in this application ("kswapd problems" hit full force and none of the
> suggested patches worked).  Even with the occasional crash, 2.6.test11 is
> way better.

Hey, I don't like the occasional crash either.

		Linus
