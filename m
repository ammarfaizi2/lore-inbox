Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWBKPjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBKPjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBKPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:39:22 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:18447 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S932324AbWBKPjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:39:22 -0500
To: Marc Koschewski <marc@osknowledge.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual
 address e1380288
References: <20060210214122.GA13881@stiffy.osknowledge.org>
	<20060210222515.GA4793@mipter.zuzino.mipt.ru>
	<20060210224238.GA5713@stiffy.osknowledge.org>
	<269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com>
	<20060211151005.GA5721@stiffy.osknowledge.org>
	<87y80hsz26.fsf@asmodeus.mcnaught.org>
	<20060211152930.GC5721@stiffy.osknowledge.org>
From: Doug McNaught <doug@mcnaught.org>
Date: Sat, 11 Feb 2006 10:39:17 -0500
In-Reply-To: <20060211152930.GC5721@stiffy.osknowledge.org> (Marc
 Koschewski's message of "Sat, 11 Feb 2006 16:29:30 +0100")
Message-ID: <87psltsy56.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski <marc@osknowledge.org> writes:

> But the trace I sent didn't (directly) do any memory allocation so
> the case was clear to me.
>
> From a developers point of view I totally agree that doing some bad
> code 'here' might crash us 'there'. But the backtrace didn't look
> like this to me...

You have no idea what might have happened a second ago, or a minute
ago, or five minutes ago.  Corrupted memory is like a
time-bomb--things don't always break right away.

-Doug
