Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUEXUzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUEXUzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbUEXUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:55:47 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:51633 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264512AbUEXUzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:55:45 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Date: Mon, 24 May 2004 22:50:38 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
In-Reply-To: <m3fz9pd2dw.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405242250.38442.tglx@linutronix.de>
X-Seen: false
X-ID: bHDdngZCwe0QPDpDfEDIBXu0V4gNLKDV8At+0iJY8oiRPckBnFSN6x@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 May 2004 21:57, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Hola!
> > This is a request for discussion..

> e.g. normally the maintainer would just answer "ok, looks good,
> applied". Now they would need to ask "ok, did you write this. if not
> through which hands did it pass"? and wait for a reply and then only
> add the patch when you know whom to put into all these Signed-off-by
> lines.

What I'm missing in this discussion is a clear distinction between patches and 
contributions.

A patch is usually a more or less small fix / improvement of existing code and 
should be treated accordingly. Recording "signed-off" chains for those would  
just using up repository space and could be used just for another type of 
useless statistics. 

Contributions are larger pieces of code introducing new functionalities or 
algorithms and contain probably stuff which could be classified as 
"Intellectual Property" and therefor Linus' proposal is surely appropriate.

I'm not sure how to distinguish exactly between patches and contributions, but 
I'm not convinced, that

- (if x > 0)
+ (if x >= 0)
signed-off hacker
signed-off module-maintainer
signed-off subsystem-maintainer
signed-off linus / andrea /...

would really be helpful and desired.

> This is not unrealistic, For example for patches that are "official
> projects" by someone it often happens that not the actual submitter
> sends the patch, but his manager (often not even cc'ing the original
> developer). ....

If the manager or who ever ensures by signing off that this code is according 
to the submission rules, then it should be sufficient for the maintainer.

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

