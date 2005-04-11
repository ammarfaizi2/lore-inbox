Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVDKTWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVDKTWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVDKTWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:22:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34283 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261887AbVDKTWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:22:18 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113246771.32686.4.camel@mindpipe>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113246771.32686.4.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 15:22:17 -0400
Message-Id: <1113247337.32686.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 15:12 -0400, Lee Revell wrote:
> On Mon, 2005-04-11 at 11:38 -0700, Mingming Cao wrote:
> > I will work on a patch for Lee to try sometime tonight.
> > 
> 
> Just FYI, this will take a while to test, because this latency seems
> quite rare.  I haven't seen it again since my original report.

Never mind, I spoke too soon.  As soon as I posted this, I hit it again.
Seems like doing a CVS checkout reliably triggers the problem.

Lee

