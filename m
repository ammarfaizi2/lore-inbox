Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274907AbTHFHr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274908AbTHFHr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:47:28 -0400
Received: from sngrel7.hp.com ([192.6.86.111]:26367 "EHLO sngrel7.hp.com")
	by vger.kernel.org with ESMTP id S274907AbTHFHr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:47:26 -0400
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: Is it possible to add this feature.
Date: Wed, 06 Aug 2003 17:47:16 +1000
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.08.06.07.47.15.831811@sourcefrog.net>
References: <3F3049D0.6040804@hsdm.com> <20030806003054.GN6541@kurtwerks.com> <20030806005348.GB15764@matchmail.com>
To: hsdm <hsdm@hsdm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Aug 2003 17:53:48 -0700, Mike Fedyk wrote:

> On Tue, Aug 05, 2003 at 08:30:54PM -0400, Kurt Wall wrote:
>> Quoth hsdm:
>> > Is it posible to limit the amount of memory or CPU time per user?
> Basically, no.
> 
>> ulimit -m
>> ulimit -t
> 
> This is per session, and the user can have many sessions.  Unless you
> limit the number of sessions a user can have...

Mike is correct that you cannot have system-wide per-user limits at the
moment, at least in the standard kernel.  However, it would be possible to
add it, if you find somebody to develop it for you.

-- 
Martin

