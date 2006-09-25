Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWIYQuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWIYQuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWIYQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:50:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34528 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751249AbWIYQuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:50:08 -0400
Subject: Re: 2.6.19 -mm merge plans (NTP changes)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609211217190.6761@scrub.home>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158805731.8648.54.camel@localhost>
	 <Pine.LNX.4.64.0609211217190.6761@scrub.home>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 09:50:04 -0700
Message-Id: <1159203005.8288.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 12:24 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 20 Sep 2006, john stultz wrote:
> 
> > No objections here, but I wanted to put forth some caution as I've seen
> > some odd NTP behavior with the full NTP patchset on my laptop (either it
> > does not converge or it just converges *much* more slowly then without).
> > Unfortunately I've not been able to collect solid enough data to analyze
> > the issue (really, each run should go for atleast a full day and always
> > run on the same network).
> 
> grumble...
> As I said before it's expected that the initial covergence is slower and I 
> need the data over multiple days to really say something about it.
> There has been really a lot of time for doing this...

Andrew, 
With apologies to Roman, I'm withdrawing my hesitation on these patches.
I was able to run tests for two days each w/ and w/o the patch I had
concerns about. And indeed, it seems if the drift file is reset, the
initial convergence is much slower (and this is really what worried me).
However once it converges it seems to keep sync as well as the current
code.

thanks
-john

