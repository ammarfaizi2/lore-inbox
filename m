Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269693AbTGJXQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269694AbTGJXQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:16:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:4356 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269693AbTGJXP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:15:58 -0400
Subject: Re: Linux 2.5.75
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1057879835.584.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 01:30:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 23:14, Linus Torvalds wrote:
> Ok. This is it. We (Andrew and me) are going to start a "pre-2.6" series,
> where getting patches in is going to be a lot harder. This is the last
> 2.5.x kernel, so take note.

Is there any expected or planned timeframe to finalize the pre-2.6
series and end up with a stable 2.6.0 kernel?

I'm worried about the current status of the 2.5 kernel scheduler. I know
that Con is working hard to nail down all the problems that some people
like me are having. I don't still feel comfortable with it, and although
Con patches are several orders of magnitude better than stock scheduler,
there are minor problems.

Sometime ago, I made down a combo patch and, sincerely, it's the one I'm
using the most for my desktop boxes as it's the one that gets better
response times and interactive feeling. For my server boxes, neither my
combo patch, neither Con or stock do feel good when the system is under
heavy load. It suffers from starvation. Simply doing a "tar jxvf" makes
logging into the system a PITA.

Just my 2 cents.

