Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbUCNNYS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbUCNNYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 08:24:18 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:54150 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S263358AbUCNNYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 08:24:16 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Sun, 14 Mar 2004 08:23:40 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-ID: <20040314132339.GA27540@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org> <20040311233525.GA14065@mtholyoke.edu> <20040312164704.GA17969@mtholyoke.edu> <20040312225606.GA19722@mtholyoke.edu> <20040313223349.3dcbfb61.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313223349.3dcbfb61.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 10:33:49PM -0800, David S. Miller wrote:
> On Fri, 12 Mar 2004 17:56:06 -0500
> Ron Peterson <rpeterso@mtholyoke.edu> wrote:
> 
> > ...just in case ...since my sense of humor is suspect ...that was a
> > joke.  Same problem persists after reboot.  I haven't installed a
> > different kernel or otherwise changed anything on 'sam' yet.  Not sure
> > what would be good to try next.
> 
> FInd out what's adding all of the netfilter rules like crazy.
> 
> It is obvious this is happening, from your profiles.  I know you
> say that you have no idea what might be doing it, but your description
> matches every other one that was reported in the past of gradual
> networking slowdown, and in each of those cases it was something
> poking netfilter in some way, and your profiles basically
> confirm that this is what is happening somehow on your box.

Don't think so.  If I revert to 2.4.20 from 2.4.21, and change nothing
else, this problem goes away.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
