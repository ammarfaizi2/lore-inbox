Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291318AbSBGV3H>; Thu, 7 Feb 2002 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291320AbSBGV2t>; Thu, 7 Feb 2002 16:28:49 -0500
Received: from bitmover.com ([192.132.92.2]:54238 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291318AbSBGV23>;
	Thu, 7 Feb 2002 16:28:29 -0500
Date: Thu, 7 Feb 2002 13:28:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207132828.E27932@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020208002324.C423@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020208002324.C423@stingr.net>; from i@stingr.net on Fri, Feb 08, 2002 at 12:23:24AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 12:23:24AM +0300, Paul P Komkoff Jr wrote:
> Also bitkeeper ... I don't use X. and without damn renametool I cannot do
> proper renaming :(((

You can.  We just have to tell you how.

cd `bk bin`
vi import		# this is a shell script
Look for a call to "bk patch".
You will see some funny arguments, those are there to generate a list
of "creates" and "deletes" which are passed to renametool.  Instead 
of calling renametool, write your on way of doing text based rename
matchup and stick it in there.

Next problem, please :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
