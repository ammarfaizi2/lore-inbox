Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTKNQst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTKNQst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:48:49 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:48034 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264544AbTKNQsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:48:46 -0500
Date: Fri, 14 Nov 2003 08:48:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114164844.GB1618@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031114150047.GC30711@work.bitmover.com> <Pine.LNX.4.44.0311140830290.1827-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311140830290.1827-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 08:35:33AM -0800, Davide Libenzi wrote:
> On Fri, 14 Nov 2003, Larry McVoy wrote:
> 
> > One of us is not getting it, maybe it's me.  To build something like
> > you describe is pretty easy IF AND ONLY IF all you are asking for is an
> > update mechanism.  As soon as you want revision history, diffs, rollbacks,
> > modifiable files, etc., you have to go to real BK.  Is that OK?  All you
> 
> Spec for bk-lite:
> 
> 1) Binary with "no worky on other SCM" kinda license
> 2) update+history+diff (no rollbacks, no modifiable files, no etc...)
> 
> In that way all current users of bk2cvs, bk2svn, bk2xxx can simply do a 
> pull from a bk repo and have they own scripts on their local machine to do 
> their bk2xxx. It will be a lower headache for you and for kernel.org 
> maintainers. Is it feasible ?

update, yes.  history, no, use bk/web.  diffs, no, use bk/web or bk.  building
it is certainly possible and you could do it yourself.  We already built the
cvs exporter which is a lot nicer than what you are asking for and building 
another thing for another 6 users seems pointless.  If you want to pay for the
engineering then contact me offline.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
