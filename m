Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUFIVJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUFIVJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUFIVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:06:40 -0400
Received: from gprs214-136.eurotel.cz ([160.218.214.136]:18818 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266176AbUFIVCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:02:53 -0400
Date: Wed, 9 Jun 2004 23:00:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Gross <mgross@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Message-ID: <20040609210054.GD17936@elf.ucw.cz>
References: <200406080829.35120.mgross@linux.intel.com> <20040608230450.GA13916@elf.ucw.cz> <200406090832.04064.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406090832.04064.mgross@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2.6.6 still fails, just like the failure reported by the thread independent of 
> swappiness: 
> 
> http://marc.theaimsgroup.com/?t=107806010900002&r=1&w=2
> 
> However; as hinted in the thread turning off premption does seem to fix the 
> problem.

Good.

> When will the CONFIG_PREEMPT work with swsusp again?  (it works with 2.6.2-mm1 
> on my system a NEC VERSA E120 Daylite with 512MB ram)  

Bad question.

It works for me (with few warnings). CONFIG_PREEMPT is not too high on
my todo list, sorry.

> Also, why does it burp out such a bogus message?  not enough swap, when its 
> trying to dump only 7000 some pages to a 700MB swap partiion that isn't used 
> yet is missleading.

How much bogus? It says not enough memory, and there really might be
not enough RAM available.

Can you quote exact message and/or suggest patch.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
