Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268804AbUHLV5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268804AbUHLV5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUHLV5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:57:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26064 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268804AbUHLVxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:53:49 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <20040812072127.GA20386@elte.hu>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu>
	 <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu>
	 <1092268536.1090.7.camel@mindpipe>  <20040812072127.GA20386@elte.hu>
Content-Type: text/plain
Message-Id: <1092347654.11134.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 17:54:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 03:21, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > There is definitely some subtle bug in the preempt-timing patch,
> > because I am getting reports of long non-preemptible sections, which
> > do not correspond to an xrun in jackd - if these were real then even a
> > 400usec non-preemptible section would cause an xrun.  I do not seem to
> > get many xruns during normal jackd operation.
> 
> could you send me these latest preempt-timing warnings?
> 

Here are all the XRUN traces and preempt-timing warnings for the last
~24 hours.  I still have not had a chance to test with the latest
patches & config changes.

http://krustophenia.net/2.6.8-rc3-O5/kern.log.txt

Here are some graphs from other test runs:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc3-O5
http://krustophenia.net/testresults.php?dataset=2.6.8-rc2-mm2-O3

For reference here's an -mm kernel without the voluntary-preempt
patches:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc3-mm2

Source code for the php script:

http://krustophenia.net/testresults.phps

I based the php script on this perl script: 

http://www.oddmuse.org/cgi-bin/oddmuse/GnuPlot_Extension

The web server is my desktop machine, so please don't complain if it
becomes unavailable without warning.  I will try to keep the links
working.

Lee

