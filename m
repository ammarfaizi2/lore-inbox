Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLULX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTLULX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:23:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:40071 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262731AbTLULX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:23:27 -0500
Date: Sun, 21 Dec 2003 11:23:16 +0000
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: ryutaroh@it.ss.titech.ac.jp, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Message-ID: <20031221112316.GE3438@mail.shareable.org>
References: <20031219123645.GA28801@ucw.cz> <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp> <20031220093532.GB6017@ucw.cz> <20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp> <200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> As I understand it there was traditionally a distinction between pipe,
> (a broken vertical line), and bar, (solid vertical line).
> 
> The markings on my keyboard are as follows:
> 
> Pipe is the fourth character on the lower-right backslash key.
> Bar is the second character on the upper-right yen key.
> 
> However, my keyboard emulates a US one in Set 2, and produces the
> Linux 'pipe' symbol, for example as in
> 
> cat foo | less
> 
> when the bar key is pressed.

I have a UK keyboard; it's a Microsoft Natural keyboard.

It has both "broken vertical line" and "solid vertical line" markings.
The former is in the usual place above backslash.  The latter is in
the alternate (altgr, as opposed to shift) position on the key which
has backquote (grave) and logical-not symbols.

Curiously, both "broken vertical line" and "solid vertical line"
generate a solid vertical line character in X (U+007C, standard pipe
character), though shift+altgr+"broken vertical line" generates a
broken vertical line character (U+08A6).

On the Linux console, all combinations generate a broken vertical
line, although that's the terminal font displaying a broken line for
the same character that X shows as a solid one.

What a strange mismash.  It would be nice if the keyboard simply
produced what is shown on the keys!

It's nice that the logical-not key actually generates a logical-not
character these days.  I'm not sure why so many keyboard have it, and
in such a prominent position, considering I've never _ever_ seen it
used in a document, and the other logical symbols aren't present.

Many older mappings emitted tilde at this position instead of
logical-not, which I often used and was quite startled the day it
started emitting what was on the key.

-- Jamie
