Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264755AbUE0PXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbUE0PXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbUE0PXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:23:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3992 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264755AbUE0PXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:23:09 -0400
Date: Thu, 27 May 2004 17:21:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527152156.GI23194@wohnheim.fh-wedel.de>
References: <20040527145935.GE23194@wohnheim.fh-wedel.de> <4382.1085670482@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4382.1085670482@ocs3.ocs.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004 01:08:02 +1000, Keith Owens wrote:
> On Thu, 27 May 2004 16:59:35 +0200, 
> =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> >Plus the script is wrong sometimes.  I have had trouble with sizes
> >around 4G or 2G, and never found the time to really figure out what's
> >going on.  Might be an alloca thing that got misparsed somehow.
> 
> Some code results in negative adjustments to the stack size on exit,
> which look like 4G sizes.  My script checks for those and ignores them.
> /^[89a-f].......$/d;

Ok, looks as if only my script is wrong.  Do you know what exactly
causes such a negative adjustment?

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
