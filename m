Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTGGRSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTGGRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:18:47 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:24988 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265110AbTGGRSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:18:45 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 10:25:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Mel Gorman <mel@csn.ul.ie>, Daniel Phillips <phillips@arcor.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030707152339.GA9669@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de>
 <Pine.LNX.4.53.0307071042470.743@skynet> <200307071424.06393.phillips@arcor.de>
 <Pine.LNX.4.53.0307071408440.5007@skynet> <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.com>
 <20030707152339.GA9669@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > The scheduler has to work w/out external input, period.
>
> Can you justify this?
>
> It strikes me that a music player's thread which requests a special
> music-playing scheduling hint is not unreasonable, if that actually
> works and scheduler heuristics do not.

Jamie, looking at those reports it seems it is not only a sound players
problem. It is fine that an application that has strict timing issues
hints the scheduler. The *application* has to hint the scheduler, not the
user. If reports about UI interactivity are true, this means that there's
something wrong in the current scheduler though. Besides the player issue.



- Davide

