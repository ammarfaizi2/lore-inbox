Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWHOUZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWHOUZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWHOUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:25:04 -0400
Received: from 1wt.eu ([62.212.114.60]:24335 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751189AbWHOUZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:25:03 -0400
Date: Tue, 15 Aug 2006 22:20:30 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mark Reidenbach <m.reidenbach@everytruckjob.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815202029.GM8776@1wt.eu>
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com> <20060815181938.GK8776@1wt.eu> <44E2263D.4010909@everytruckjob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E2263D.4010909@everytruckjob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:53:33PM -0500, Mark Reidenbach wrote:
> Willy Tarreau wrote:
> >He may very well have an IOS based 1600 or equivalent doing a very dirty 
> >NAT.
> >
> >Willy
> >
> >  
> Willy, I am in fact running an IOS based NAT/firewall on a 1811.   It's 
> IOS version 12.3(8)YI1.  Do you know if this version has a "very dirty 
> NAT" implementation?   If you don't, I think I'll just try a few spare 
> home routers and see if their NAT implementation is cleaner than my Cisco's.

I have absolutely no idea. If they borrowed the session tracking code from
the PIX, you might have window tracking inside it, which might cause what
you observe if it's buggy. But that's just supposition from me.

> Mark Reidenbach
> EveryTruckJob.com
> M.Reidenbach@EveryTruckJob.com
> Phone: (205)722-9112

Regards,
willy

