Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270206AbRHGMbW>; Tue, 7 Aug 2001 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270207AbRHGMbM>; Tue, 7 Aug 2001 08:31:12 -0400
Received: from sync.nyct.net ([216.44.109.250]:33299 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S270206AbRHGMbE>;
	Tue, 7 Aug 2001 08:31:04 -0400
Date: Tue, 7 Aug 2001 08:37:27 -0400
From: Michael Bacarella <mbac@nyct.net>
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807083727.A16735@sync.nyct.net>
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain> <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>; from rmack@mackman.net on Mon, Aug 06, 2001 at 10:55:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apparently some of you have missed the point.  Currently, the only way to
> write any form of encryption application is to have it run setuid root so
> it can lock pages in RAM.  Otherwise, files (or keys) that are encrypted
> on disk may be left in an unencrypted state on swap, allowing for
> potential recovery by anyone with hardware access.  Encrypted swap makes
> locking pages unnecessary, which relieves many sysadmins from the anxiety
> of having yet-another-setuid application installed on their server in
> addition to freeing up additional pages to be swapped.

Not to trivialize your burden as a sys admin, but if you don't think
you're going to run into swap often (not quoted), and feel that it's
a security hazard... why not disable swap entirely?

If a system dips into swap, maybe it doesn't have enough RAM.
And if security is that important to you, dropping the cash on the
additional RAM should be a non-issue.

Besides, who can argue against more RAM?

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
