Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRAIPHv>; Tue, 9 Jan 2001 10:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIPHl>; Tue, 9 Jan 2001 10:07:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:42207 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130012AbRAIPH0>;
	Tue, 9 Jan 2001 10:07:26 -0500
Date: Tue, 9 Jan 2001 10:19:23 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Scott Laird <laird@internap.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in authentication.
In-Reply-To: <Pine.LNX.4.21.0101081253110.13252-100000@lairdtest1.internap.com>
Message-ID: <Pine.LNX.4.31.0101091015120.18106-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Scott Laird wrote:

>
> Is syslog running correctly?  When syslog screws up, it very frequently
> results in this sort of problem.
>

I would guess that syslog is okay.  I'm getting plenty of entries in my
various logs, along with a few boxes remote logging into this server.

Another interesting thing I have noticed about this delay.  If I remove
the data in the password field from the shadow file ("username::...")
there is no pause during login.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
