Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUFSWu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUFSWu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUFSWu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:50:26 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:59340 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264748AbUFSWuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:50:15 -0400
Date: Sat, 19 Jun 2004 23:49:33 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040619234933.214b810b.spyro@f2s.com>
In-Reply-To: <1087681604.2121.96.camel@mulgrave>
References: <1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave
	<40D359BB.3090106@pacbell.net>
	<1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net>
	<1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net>
	<20040619214126.C8063@flint.arm.linux.org.uk>
	<1087681604.2121.96.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2004 16:46:42 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> But we still need some sort of fallback where the platform really
> cannot do this.  And that fallback is going to be ioremap and all the
> other paraphenalia.  So, the thing that bothers me is that if we have
> to have the fallback which is identical to what every other driver
> that uses on-chip memory does anyway, is there any point to placing
> this in the DMA API?

Can you describe a system where its impossible to use the DMA API or one
of the modifications proposed here? what sort of hardware does this and
why?
