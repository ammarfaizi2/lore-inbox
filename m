Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVAGGhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVAGGhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVAGGhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:37:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:30366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbVAGGhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:37:12 -0500
Date: Thu, 6 Jan 2005 22:37:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501062236060.2272@ppc970.osdl.org>
References: <200501070313.j073DCaQ009641@hera.kernel.org>
 <20050107034145.GI9636@holomorphy.com> <Pine.LNX.4.58.0501062222500.2272@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, Linus Torvalds wrote:
> 
> I worried a bit about latency, but my test-run of four before/after was in 
> the noise. It's bound to be worse because of the extra allocation, but 
> it's not clearly visible.

Btw, this is not to say that it isn't measurable: I'm sure it is. It's
just not as _obvious_ as the throughput improvement. If somebody were to
do some more controlled latency tests... Hint, hint.

		Linus
