Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVEBTCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVEBTCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVEBTCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:02:34 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:4796 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261654AbVEBTC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:02:29 -0400
Message-ID: <1785.10.10.10.24.1115060548.squirrel@linux1>
In-Reply-To: <427650E7.2000802@tmr.com>
References: <118833cc05042908181d09bdfd@mail.gmail.com><118833cc05042908181d09bdfd@mail.gmail.com>
    <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com>
Date: Mon, 2 May 2005 15:02:28 -0400 (EDT)
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
From: "Sean" <seanlkml@sympatico.ca>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: "Matt Mackall" <mpm@selenic.com>, "Morten Welinder" <mwelinder@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2005 12:10 pm, Bill Davidsen said:

> Now look at pulling 41MB over a T1 link. All of a sudden I care bigtime!
> I want very much to use my bandwidth for other things, I don't want 41MB
> added to my backup, etc. Disk space is cheap, but unless you ignore
> backups and have an OC3 or so, these numbers are large enough to be
> irritating. Not a huge issue, just one of those "piss me off every time
> I do it" things.

That 41MB or lets say 200MB is spread over several months between
releases.   Pulling once a day from the git public repository, makes this
barely noticeable.  In the future there may be optimized protocols to
handle this more efficiently.

You bring up a good point about backups though.  Eventually it might be
nice to have a utility that exports/imports a git repository in a flat
file using deltas rather than snapshots.   Such an export format would
make backups and tarballs cheaper.

Sean


