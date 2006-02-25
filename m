Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWBYG3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBYG3e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBYG3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:29:34 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:38821 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932341AbWBYG3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:29:34 -0500
Date: Sat, 25 Feb 2006 01:22:16 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86: clean up early_printk output
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200602250124_MC3-1-B940-4AED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200602250529.11099.ak@suse.de>

On Sat, 25 Feb 2006 at 05:29:10 +0100, Andi Kleen wrote:

> early_printk is designed to do absolutely minimal work to get the 
> message out. Your patch adds too much potential disturbance 
> imho.

You're kidding... right?

early_printk copies the entire screen up, line-by-line, in order to do
scrolling, then blanks the bottom line using the exact code I used to
clear to EOL.  How can that be OK if my fix isn't?

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

