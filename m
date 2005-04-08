Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVDHSNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVDHSNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVDHSNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:13:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60078 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262911AbVDHSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:12:51 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 14:12:49 -0400
Message-Id: <1112983970.10565.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 11:10 -0700, Mingming Cao wrote:
> However I am still worried that the rw lock will allow concurrent files
> trying to lock the same window at the same time. Only one succeed
> though., high cpu usage then.  And also, in the normal case the
> filesystem is not really full, probably rw lock becomes expensive.

FWIW this was a 125GB filesystem, about 70% full.

Lee

