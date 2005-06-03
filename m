Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFCSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFCSHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFCSHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:07:54 -0400
Received: from mail.ccur.com ([208.248.32.212]:12804 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261456AbVFCSHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:07:42 -0400
Message-ID: <42A09C6C.8030104@ccur.com>
Date: Fri, 03 Jun 2005 14:07:40 -0400
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dan@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2005 18:07:41.0527 (UTC) FILETIME=[223CFE70:01C56867]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
 > From: Daniel Jacobowitz <dan@debian.org>
 > Date: Fri, 3 Jun 2005 13:34:33 -0400
 > To: John Blackwood <john.blackwood@ccur.com>
 > CC: linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de, 
akpm@osdl.org, bugsy@ccur.com
 >
 > On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:

 > >> The reason for this behavior is due to the fact that:
 > >>
 > >> - We saved off the eflags (with the TF bit set) in setup_sigcontext()
 > >>   before we single stepped into the user's signal handler.
 >
 >
 > You didn't say what kernel you were using.  I believe this was fixed
 > some time ago.

Hi Dan,

I observed this behavior in a 2.6.11.10 kernel.  The code in 2.6.11.11
looks the same in this area... this is the i386 code that I am speaking of.

I guess that 'some time ago' is more recent than that?


If so, then please excuse me... and it's great that this is fixed.



