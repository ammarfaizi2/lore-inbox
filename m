Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUAPW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUAPW7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:59:16 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:57961 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S265969AbUAPW7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:59:15 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: Stephen Smoogen <smoogen@lanl.gov>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2582475408.1074292759@aslan.btc.adaptec.com>
References: <1074289406.5752.5.camel@smoogen2.lanl.gov>
	 <2582475408.1074292759@aslan.btc.adaptec.com>
Content-Type: text/plain
Organization: CCN-2 ESM/SSC
Message-Id: <1074293952.1321.5.camel@smoogen2.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 15:59:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-16 at 15:39, Justin T. Gibbs wrote:
> > Booting problems with aic7xxx with stock kernel 2.4.24.
> 
> ...
> 
> > Unexpected busfree while idle
> > SEQ 0x01
> 
> A problem with similar symptoms was corrected in driver version 6.2.37
> back in August of last year.  Can you try using the latest driver source
> from here:
> 
> 	http://people.FreeBSD.org/~gibbs/linux/SRC/
> 
> and see if your problem persists?  The aic79xx driver archive at the
> above location includes both the aic7xxx and aic79xx drivers.  If this
> does not resolve your problem there are other debugging options we can
> enable that may aid in tracking down the problem.

Hi I did that already; sorry for not being clearer about it in the bug
report. For some of my systems I had patched my kernel to have the
latest source code from your site for our aic79xx machines. I ran that
kernel on these other systems and it locked up in a similar state.

 I am ready for the additional debugging options :). Thanks for your
quick response.



-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- So shines a good deed in a weary world. = Willy Wonka --

