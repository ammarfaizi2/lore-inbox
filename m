Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTJPRdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTJPRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:33:20 -0400
Received: from waste.org ([209.173.204.2]:8863 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263125AbTJPRdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:33:20 -0400
Date: Thu, 16 Oct 2003 12:31:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016173135.GL5725@waste.org>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8E8101.70009@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 07:29:05AM -0400, Jeff Garzik wrote:
> 
> So, given that trend and also given the existing /dev/[u]random, I 
> disagree completely:  /dev/frandom is the perfect example of something 
> that should _not_ be in the kernel.  If you want /dev/urandom faster, 
> then solve _that_ problem.  Don't try to solve a /dev/urandom problem by 
> creating something totally new.

I have some performance fixes for /dev/urandom, but there's a fair
amount of other cleanup that has to go in first.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
