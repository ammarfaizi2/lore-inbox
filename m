Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVLCWIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVLCWIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLCWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:08:48 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:3515 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750873AbVLCWIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:08:47 -0500
Subject: Re: 2.6.14-rt21 & evolution
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1133642866.16477.11.camel@cmn3.stanford.edu>
References: <1133642866.16477.11.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 17:08:56 -0500
Message-Id: <1133647737.5890.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 12:47 -0800, Fernando Lopez-Lezcano wrote:
> Hi Ingo... just a heads up. I've been running 2.6.14-rt21 for a few days
> and the timing issues seem to be gone on my X2 machine, as the main
> timing is no longer derived from the TSC's. Very good! It should work
> great with a patched Jack (that does not use TSC for its internal timing
> measurements). 
> 
> But I'm seeing a recurrent problem that so far I can only blame -rt21
> for. When I start evolution (on a fully patched 32 bit fc4 system) it
> eventually dies.

I was seeing exactly the same problem here.  I don't think it's related
to -rt21, I think someome posted a malformed message to LKML or one of
the other lists that we are both on and Evo is choking on it.  It starts
to download the mail then you get "Storing folder" for like 5 minutes
then it crashes.

I finally managed to get into my mail by (carefully) deleting ALL
metadata - all the .index, .index.data, .cmeta, and .ev-summary files
from .evolution.

Lee

