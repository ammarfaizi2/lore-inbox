Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVDKTQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVDKTQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVDKTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:16:17 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48874 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261890AbVDKTMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:12:54 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113244710.4413.38.camel@localhost.localdomain>
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
Content-Type: text/plain
Date: Mon, 11 Apr 2005 15:12:50 -0400
Message-Id: <1113246771.32686.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 11:38 -0700, Mingming Cao wrote:
> I will work on a patch for Lee to try sometime tonight.
> 

Just FYI, this will take a while to test, because this latency seems
quite rare.  I haven't seen it again since my original report.
Hopefully I can reproduce it with enough dbench processes.

This seems to agree with your earlier observation that we seem to have
been quite unlucky.

Anyway, if I understand the thread it seems like this could increase
performance as well as help latency.

Lee

