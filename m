Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269841AbUIDJEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269841AbUIDJEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269843AbUIDJEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:04:48 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:6801 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269841AbUIDJEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:04:46 -0400
Message-ID: <4139851B.8070100@yahoo.com.au>
Date: Sat, 04 Sep 2004 19:04:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [PATCH] schedstats additions
References: <41394D79.40205@yahoo.com.au> <200409041026.51519.rjw@sisk.pl>
In-Reply-To: <200409041026.51519.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Dnia Saturday 04 of September 2004 07:07, Nick Piggin napisa³:
> 
>>Hi,
>>I have a patch here to provide more useful statistics for me. Basically
>>it moves a lot more of the balancing information into the domains instead
>>of the runqueue, where it is nearly useless on multi-domain setups (eg.
>>SMT+SMP, SMP+NUMA).
> 
> 
> Which kernel version it is against?
> 

-mm3 ... oh yeah that has nicksched in it, sorry that would put a spanner
in the works.

I'll redo it to suit 2.6 if Rick acks it - the main info he needs is still
valid, that is the output format.

Thanks
Nick
