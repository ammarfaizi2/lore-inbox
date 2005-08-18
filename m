Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVHRFth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVHRFth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHRFth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:49:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbVHRFtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:49:36 -0400
Date: Wed, 17 Aug 2005 22:48:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-Id: <20050817224805.17f29cfb.akpm@osdl.org>
In-Reply-To: <43042114.7010503@drzeus.cx>
References: <42FF3C05.70606@drzeus.cx>
	<20050817155641.12bb20fc.akpm@osdl.org>
	<43042114.7010503@drzeus.cx>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> >I'm thinking that it would be better to not have the config option there
>  >and then re-add it late in the 2.6.14 cycle if someone reports problems
>  >which cannot be fixed.  Or at least make it default to 'y' so we get more
>  >testing coverage, then remove the config option later.  Or something.
>  >
>  >Thoughts?
>  >  
>  >
> 
>  Removing it would be preferable by me. All that #ifdef tends to clutter
>  up the code. After som initial problem with a buggy card everything has
>  worked flawlesly.

OK..  Please send an additional patch for that sometime?
