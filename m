Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVCNFIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVCNFIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVCNFGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:06:00 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:22097 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261533AbVCNFFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:05:02 -0500
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christian Schmid <webmaster@rapidforum.com>
Cc: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <423518C7.10207@rapidforum.com>
References: <4229E805.3050105@rapidforum.com>
	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>
	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>
	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>
	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>
	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>
	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>
	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>
	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com>
	 <1110775215.5131.17.camel@npiggin-nld.site> <423518C7.10207@rapidforum.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 16:04:48 +1100
Message-Id: <1110776689.5131.37.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 05:53 +0100, Christian Schmid wrote:

> > The other thing that worries me is your need for lower_zone_protection.
> > I think this may be due to unbalanced highmem vs lowmem reclaim. It
> > would be interesting to know if those patches I sent you improve this.
> > They certainly improve reclaim balancing for me... but again I guess
> > you'll be reluctant to do much experimentation :\
> 
> I have tested your patch and unfortunately on 2.6.11 it didnt change anything :( I reported this 
> before, or do you mean something else? I am of course willing to test patches as I do not want to 
> stick with 2.6.10 forever.

Well I hope that scheduler developments in progress will put future
kernels at least on par with 2.6.10 again (and hopefully better).

Yes you did report that my patch didn't help 2.6.11, but could those
results have been influenced by the suboptimal HT scheduling? If so,
I was interested in the results with HT turned off.

Nick


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
