Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312898AbSDSVNI>; Fri, 19 Apr 2002 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSDSVNH>; Fri, 19 Apr 2002 17:13:07 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:40669 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S312898AbSDSVNH>;
	Fri, 19 Apr 2002 17:13:07 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15552.34913.686564.487970@napali.hpl.hp.com>
Date: Fri, 19 Apr 2002 14:13:05 -0700
To: Rick Haines <rick@kuroyi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read latency (ia64)
In-Reply-To: <20020418140622.GA31405@sasami.kuroyi.net>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 18 Apr 2002 10:06:22 -0400, Rick Haines <rick@kuroyi.net> said:

  Rick> I have a Lion with 4 666mhz B3 stepping cpus and 4GB ram
  Rick> running Debian unstable with kernel 2.4.18 and the 020410 ia64
  Rick> patch (I have the same problem with 2.4.9-itanium-smp from the
  Rick> archive).

  Rick> I have a program that reads large files in increments of 81920
  Rick> blocks.  After about 9600 read calls I get about a dozen reads
  Rick> that take about 3 seconds each.  Does anyone have any ideas as
  Rick> to a cause/solution?  (I have 4 other threads working/possibly
  Rick> writing output at the same time, although in this case only 1
  Rick> of them would be active at the same time).  I am also running
  Rick> a program that callocs almost all my ram to make sure none of
  Rick> the file is cached.

I don't think anyone will be able to help you without a test case.
Do you have a minimal test case that reproduces the problem?

	--david
