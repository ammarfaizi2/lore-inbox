Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUCYOZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUCYOZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:25:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50138 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263165AbUCYOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:52 -0500
Date: Thu, 25 Mar 2004 15:16:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
Message-ID: <20040325141625.GF1505@openzaurus.ucw.cz>
References: <20040316154611.GA31510@mulix.org> <200403161849.i2GInfF0007372@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403161849.i2GInfF0007372@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-03-04 14:49:41, Horst von Brand wrote:
> Muli Ben-Yehuda <mulix@mulix.org> said:
> 
> [...]
> 
> > This is something that I've thought of doing in the past. The reason I
> > didn't pursue it further is that it's impossible to get it right for
> > all cases, and it attacks the problem in the wrong place. The kernel
> > shouldn't need to guess(timate) what the process is going to do. The
> > userspace programmer, who knows what his process is going to do,
> > should tell the kernel.
> 
> People have been known to lie on occasion, particularly when it is to their
> advantage...

You could heavily penalize process that lied... Or perhaps his user.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

