Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTGGOkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 10:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTGGOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 10:40:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:12185 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264993AbTGGOkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 10:40:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 07:47:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mel Gorman <mel@csn.ul.ie>
cc: Daniel Phillips <phillips@arcor.de>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <Pine.LNX.4.53.0307071408440.5007@skynet>
Message-ID: <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de>
 <Pine.LNX.4.53.0307071042470.743@skynet> <200307071424.06393.phillips@arcor.de>
 <Pine.LNX.4.53.0307071408440.5007@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Mel Gorman wrote:

> On Mon, 7 Jul 2003, Daniel Phillips wrote:
>
> > And set up distros to grant it by default.  Yes.
> >
> > The problem I see is that it lets user space priorities invade the range of
> > priorities used by root processes.
>
> That is the main drawback all right but it could be addressed by having a
> CAP_SYS_USERNICE capability which allows a user to renice only their own
> processes to a highest priority of -5, or some other reasonable value
> that wouldn't interfere with root processes. This capability would only be
> for applications like music players which need to give hints to the
> scheduler.

The scheduler has to work w/out external input, period. If it doesn't we
have to fix it and not to force the user to submit external hints.



- Davide

