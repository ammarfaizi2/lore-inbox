Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264878AbUE0Q36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264878AbUE0Q36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUE0Q36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:29:58 -0400
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:39697 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264878AbUE0Q34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:29:56 -0400
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [RFD] Explicitly documenting patch submission
Date: Thu, 27 May 2004 12:13:05 -0400
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2004.05.27.16.13.04.82253@yahoo.com>
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <20040527145127.GB3375@work.bitmover.com>
To: linux-kernel@vger.kernel.org, lm@bitmover.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 07:51:27 -0700, Larry McVoy wrote:
> I suspect that with a little practice this could be quite useful.  
> I could build tools which record the secondary patches as diffs to
> the patches (I think) and if you have ever read a diff of a diff 
> it is suprisingly useful.  I tend to save diffs of my work in 
> progress and then later I'll generate diffs again and diff them to 
> get my context back.

This is a classic case of wanting an audit trail just like you have in
accounting packages. For audit trails you have to have the entire trail,
not just pieces of it. 

I like the idea of nested packages signed by each person who touched it.
The gives a perfect audit trail back to who authored each line. I'm sure
bk could be modified to produce these automatically.

I don't believe the size of this would get out of control. Only the master
Linux repository has to keep all of it. bk clone could get a new option
that says, i don't care about the downstream audit trail. Disks are cheap,
I doubt if the entire Linux audit trail would fill up more than a couple
of them.

Audit trails are something that are rarely looked at but of vital
importance. Linux needs complete and accurate audit trails. I agree that
audit trails can clutter up patches, but the patches have to have these
trails. The way to address this is via tools that convert the new patches
into the old formats for people to read. Plus the bitkeeper interface
would also hide all of the detail unless asked. Of course other source
control systems will also need a set of helper tools too.

Another problem is that you need a central key repository. Since it's
pretty stupid to for each developer to send $2,000 to verisign for a key
maybe bitmover would consider running the key repository. This is a
painful job, if they want to do it, I'd let them.


Jon Smirl, jonsmirl@yahoo.com


