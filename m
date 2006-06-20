Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWFTEWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWFTEWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 00:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWFTEWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 00:22:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29835 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932579AbWFTEWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 00:22:53 -0400
Date: Tue, 20 Jun 2006 05:22:51 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
Message-ID: <20060620042250.GP27946@ftp.linux.org.uk>
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:14:45PM -0700, Linus Torvalds wrote:
> But that's not the point.
> 
> I want to know what I'm pulling _ahead_ of time, AND I WANT TO KNOW THAT 
> WHAT I PULL IS WHAT THE SENDER INTENDED ME TO PULL!

No arguments; that's a different question.

I'm _not_ saying that you should <something>.

I'm saying that often _I_ am curious about the log _in_ _some_ _remote_ _tree_.
Preferably - without fetch + git log + rm .git/refs/tmp + git prune, which
is how I do that now.  git prune is quite slow, for one thing...

It's not about kernel or getting stuff merged; the question is about git
and cheaper way to do the thing I often find useful.  IOW, read that as
"BTW, is there a way to get such information out of git without too much
PITA?"
