Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTABLwY>; Thu, 2 Jan 2003 06:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTABLwX>; Thu, 2 Jan 2003 06:52:23 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:38842 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261427AbTABLwX>; Thu, 2 Jan 2003 06:52:23 -0500
Date: Thu, 2 Jan 2003 13:00:33 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kallsyms crashes in 2.5.54
Message-ID: <20030102120033.GA4266@averell>
References: <20030102091325.GA24352@averell> <3E1427FD.16A7B021@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1427FD.16A7B021@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 12:52:29PM +0100, Andrew Morton wrote:
> Andi Kleen wrote:
> > 
> > The kernel symbol stem compression patch included in 2.5.54 unfortunately
> > had a few problems, triggered by various circumstances.
> > 
> 
> With your patch I am still seeing an instant oops when running top(1):

Did you make sure the .tmp_kallsym* files in your kernel build were
regenerated ? 

-Andi
