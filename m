Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVFQM4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVFQM4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 08:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVFQM4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 08:56:10 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:35027 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261943AbVFQM4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 08:56:07 -0400
Date: Fri, 17 Jun 2005 08:56:07 -0400
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050617125607.GA23488@csclub.uwaterloo.ca>
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <Pine.LNX.4.61.0506161036370.30607@chaos.analogic.com> <20050616150419.GY23488@csclub.uwaterloo.ca> <200506162118.18470.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506162118.18470.pmcfarland@downeast.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 09:18:06PM -0400, Patrick McFarland wrote:
> On Thursday 16 June 2005 11:04 am, Lennart Sorensen wrote:
> >  Most people seem happy with 50 or so being a good limit even though many
> >  systems support much longer. 
> 
> 50 characters or 50 bytes? Because in the case of UTF-8, if you do a lot of 
> three byte characters (which require four bites to encode), 50 bytes is very 
> short.

I would think most languages that need 2 or 3 bytes per character would
need a lot less characters, although I think I can think of a few cases
where that isn't true.

Well how about making it '50 characters seems plenty for most people to
be happy'.  If you can handle a couple hundred bytes that should be ok,
and I think most filesystems can.

Len Sorensen
