Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTBUAO5>; Thu, 20 Feb 2003 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTBUAO5>; Thu, 20 Feb 2003 19:14:57 -0500
Received: from octopussy.utanet.at ([213.90.36.45]:47843 "EHLO
	octopussy.utanet.at") by vger.kernel.org with ESMTP
	id <S267339AbTBUAOz>; Thu, 20 Feb 2003 19:14:55 -0500
Date: Fri, 21 Feb 2003 01:24:57 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030221002456.GB8096@lilith.homenet>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
References: <20030219171432.A6059@smp.colors.kwc> <Pine.LNX.4.50L.0302192004410.2329-100000@imladris.surriel.com> <20030220124833.GB4051@lilith.homenet> <Pine.LNX.4.50L.0302201019250.2329-100000@imladris.surriel.com> <20030220150559.A27331@smp.colors.kwc> <Pine.LNX.4.50L.0302201258070.2329-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0302201258070.2329-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

On Thu, Feb 20, 2003 at 01:00:12PM -0300, Rik van Riel wrote:
> On Thu, 20 Feb 2003, Dejan Muhamedagic wrote:
> > > >
> > > > AIX vmtune -P is equivalent to the Linux cache-max, but cache-max
> > > > is not implemented.
> 
> OK, vmtune -p is equivalent to cache-min, vmtune -P is
> equivalent to cache-borrow ...

Yes, I was wrong ...

> It looks like AIX doesn't have a cache-max, either.

... and now I can't think of a good reason for implementing
cache-max at all.

Cheers!

Dejan
