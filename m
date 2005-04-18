Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVDRTNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVDRTNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVDRTNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:13:23 -0400
Received: from waste.org ([216.27.176.166]:40834 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262023AbVDRTNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:13:18 -0400
Date: Mon, 18 Apr 2005 12:13:16 -0700
From: Matt Mackall <mpm@selenic.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fortuna
Message-ID: <20050418191316.GL21897@waste.org>
References: <20050414141538.3651.qmail@science.horizon.com> <d3poiv$vrn$2@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3poiv$vrn$2@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please reply to all when posting to lkml]

On Sat, Apr 16, 2005 at 01:08:47AM +0000, David Wagner wrote:
> >First, a reminder that the design goal of /dev/random proper is
> >information-theoretic security.  That is, it should be secure against
> >an attacker with infinite computational power.
> 
> I am skeptical.
> I have never seen any convincing evidence for this claim,
> and I suspect that there are cases in which /dev/random fails
> to achieve this standard.
> 
> And it seems I am not the only one.  See, e.g., Section 5.3 of:
> http://eprint.iacr.org/2005/029

Unfortunately, this paper's analysis of /dev/random is so shallow that
they don't even know what hash it's using. Almost all of section 5.3
is wrong (and was when I read it initially).

-- 
Mathematics is the supreme nostalgia of our time.
