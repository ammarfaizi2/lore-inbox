Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVKOWuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVKOWuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVKOWuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:50:39 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:56733 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965057AbVKOWui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:50:38 -0500
Message-ID: <437A663D.5040808@us.ibm.com>
Date: Tue, 15 Nov 2005 14:50:37 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
References: <1132012281.24066.36.camel@localhost.localdomain> <20051114161704.5b918e67.akpm@osdl.org> <1132015952.24066.45.camel@localhost.localdomain> <20051114173037.286db0d4.akpm@osdl.org> <Pine.LNX.4.58.0511150247160.24064@skynet>
In-Reply-To: <Pine.LNX.4.58.0511150247160.24064@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>>ah-hah.  We've had machines stuck in radeon_do_wait_for_idle() before.  In
>>fact, my workstation was doing it a year or two back.
>>
>>Are you able to identify the most recent kernel which didn't do this?
>>
>>David, is there a common cause for this?  ISTR that it's a semi-FAQ.
> 
> 
> Yes invariably the GPU has crashed and isn't responding to anything.
> unfortuantely radeons have a lot of reasons for crashing most of them very
> unrelated to anything like reality...  we normally try and approach them
> on a case by case basis as some can be solved easily some not so...
> 
> Also what X was doing etc at the time is invalulable info..

What information I can collect ? My machine seems to be reproducing this
pretty regularly.

Thanks,
Badari

