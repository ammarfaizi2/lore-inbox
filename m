Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWBHDHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWBHDHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWBHDHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:07:19 -0500
Received: from kanga.kvack.org ([66.96.29.28]:3256 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750915AbWBHDHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:07:18 -0500
Date: Tue, 7 Feb 2006 22:02:34 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Grant Coady <gcoady@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Message-ID: <20060208030234.GE14748@kvack.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <20060208022411.GD14748@kvack.org> <igmiu15lgo31rh92ugm7i0c35jcsrj0631@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <igmiu15lgo31rh92ugm7i0c35jcsrj0631@4ax.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:50:10PM +1100, Grant Coady wrote:
> Vague 'cos I do not know where the problem is.  One might say slowdown 
> is like a near a 1ms delay per line output, but slowdown does not 
> correlate to kernel tick frequency.  :(

Two things come to mind: can you try doing a vmstat 1 while running the 
test and compare 2.4 vs 2.6?  Also, does it make a difference if you switch 
from the e100 driver to eepro100?

> I'll take a look at oprofile, report back if I can make sense of it ;)

If the CPU is pegged that will guide fixing things quite nicely, but the 
fact that it's 1ms per line sounds like something more sinister.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
