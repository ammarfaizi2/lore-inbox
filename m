Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTGZItD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTGZItD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:49:03 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:8577 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S268737AbTGZItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:49:01 -0400
Date: Sat, 26 Jul 2003 17:03:48 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Fedyk <mfedyk@matchmail.com>, Wiktor Wodecki <wodecki@gmx.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       Danek Duvall <duvall@emufarm.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] O8int for interactivity
Message-ID: <20030726090348.GA3119@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <200307232155.27107.kernel@kolivas.org> <1058978784.740.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058978784.740.4.camel@teapot.felipe-alfaro.com>
X-Operating-System: Linux 2.4.21-ck3
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Felipe Alfaro Solana">
> On Wed, 2003-07-23 at 13:55, Con Kolivas wrote:
> > Here is an addon to the interactivity work so far. As the ability to become 
> > interactive was made much faster and easier in O6*, I was able to remove a lot 
> > of extra code uneeded in this latest patch, and remove a lot of the noticable 
> > unfairness in the code. This is closer to the original scheduler code after 
> > all these patches than any of my previous patches. All of O8int is aimed
> > at fixing unfairness in my interactivity patches.
> 
> Overall it feels better. I can't make XMMS skip at all. Under low load,
> X is very smooth, but X is still jerky/jumpy when the system is under
> heavy load (while true; do a=2; done) and I start moving windows all
> around my KDE desktop. Renicing the X server to -20 makes it very smooth
> under load (yeah, I know I shouldn't do this).

X server was niced to -10. XMMS doesn't skip when under load, except
when I try to hide, and unhide maximised aterm. Other than that,
everything went smoothly. Didn't encounter what I experienced when I
was using O7int (con knows what happened :D). X server was niced to 0
now. So far so good. 

Eugene

