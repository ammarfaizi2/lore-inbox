Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310219AbSCKRGl>; Mon, 11 Mar 2002 12:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310222AbSCKRGW>; Mon, 11 Mar 2002 12:06:22 -0500
Received: from bitmover.com ([192.132.92.2]:429 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310219AbSCKRFO>;
	Mon, 11 Mar 2002 12:05:14 -0500
Date: Mon, 11 Mar 2002 09:05:12 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020311090512.N26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Jonathan A. George" <JGeorge@greshamstorage.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Mar 07, 2002 at 08:59:47PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 08:59:47PM -0300, Rik van Riel wrote:
> 3) graphical 2-way merging tool like bitkeeper has
>    (this might not seem essential to people who have
>    never used it, but it has saved me many many hours)

I haven't verified this, but I suspect what Rik is using is the 3-way
file merge.  If it looks like 

	http://www.bitkeeper.com/newmerge.gif

that's a 3 way file merge, the 2 big side by side windows are showing
you 3 diffs, the diff from the ancestor to the local version in the left
window, the diff from the ancestor to the remote version in the right
window, and then side by side diffs in that they are lined up.

If Rik is using the 2 way file merge and likes that, he's in for a quantum
leap in productivity, commercial customers have reported as much as an
18:1 productivity increase from the 3 way file merge.

And by the way, if you ever get around to understanding how this tool works,
you'll then understand why I keep saying that BitKeeper != diff&patch.  It
is impossible to do what this tool does with a diff&patch based system, it
simply can't be done.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
