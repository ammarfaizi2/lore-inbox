Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVCOCeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVCOCeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVCOCeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:34:19 -0500
Received: from waste.org ([216.27.176.166]:32391 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262205AbVCOCeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:34:06 -0500
Date: Mon, 14 Mar 2005 18:33:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][1/2] SquashFS
Message-ID: <20050315023355.GK32638@waste.org>
References: <4235BAC0.6020001@lougher.demon.co.uk> <20050315003802.GH3163@waste.org> <42363EAB.3050603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42363EAB.3050603@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 12:47:23PM +1100, Nick Piggin wrote:
> Matt Mackall wrote:
> 
> >>+	for (;;) {
> >
> >while (1)
> 
> I always thought for (;;) was preferred. Or at least acceptable?

The for (;;) form has always struck me as needlessly clever and I've
known it to puzzle coworkers. I try to make my for loops fall into the
mold of simple initialize/test/advance. But no, I'm not aware of any
LKML concensus opinion on this particular point.

The assignment-in-if problem is a bit more serious as it exacerbates
the jammed-up-against-the-right-margin formatting issues.

-- 
Mathematics is the supreme nostalgia of our time.
