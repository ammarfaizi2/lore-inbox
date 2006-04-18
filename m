Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWDRKDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDRKDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWDRKDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:03:48 -0400
Received: from ms-smtp-04.tampabay.rr.com ([65.32.5.134]:47602 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750818AbWDRKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:03:47 -0400
Message-ID: <4444B974.2080404@cfl.rr.com>
Date: Tue, 18 Apr 2006 06:03:32 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Lee Revell <rlrevell@joe-job.com>, markh@compro.net,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT question : softirq and minimal user RT priority
References: <200601131527.00828.Serge.Noiraud@bull.net> <1137167600.7241.22.camel@localhost.localdomain> <4443966B.8020802@compro.net> <1145286325.16138.26.camel@mindpipe> <44449EE2.8070907@cfl.rr.com>
In-Reply-To: <44449EE2.8070907@cfl.rr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:

> 
> The default IRQ threads seem to be at RT priorities 25-49. So a user
> should never have a RT compute bound task at a RT priority higher than
> 25? Doesn't seem quite right. In any case, I have other less compute
> bound lower priority RT tasks also running on the same CPU so my high
> priority RT task must be giving up the CPU somewhere along the line. Why
> is it not able to receive signals? Something is not quite right here.
> 
> Regards
> Mark
> 

Actually those other tasks are on another CPU. Sorry. I still think
something is amiss here?

Mark
