Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUDCAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDCAg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:36:57 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:41841 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbUDCAgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:36:54 -0500
Message-ID: <406E017D.9040107@yahoo.com.au>
Date: Sat, 03 Apr 2004 10:12:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Wong <markw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.6.5-rc3-mm4
References: <20040401020512.0db54102.akpm@osdl.org> <200404021904.i32J4M215682@mail.osdl.org> <20040402115601.24912093.akpm@osdl.org> <406DFABD.8070400@yahoo.com.au> <20040402161022.A26902@osdlab.pdx.osdl.net>
In-Reply-To: <20040402161022.A26902@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wong wrote:
> On Sat, Apr 03, 2004 at 09:43:57AM +1000, Nick Piggin wrote:
> 
>>Which looks like it is taking a lot longer (is it the same test?)
>>It is difficult to tell how idle each one is due to lack of total
>>ticks reported, but, copy_to/from_user is 3% the amount of idle
>>time in 2.6.3, while being 3.5% the amount of idle time in your
>>profile.
> 
> 
> Whoops, I changed when the sample is take.  This 2.6.3 results samples
> when the test is ramping up, while all the subsequent tests are sampling
> after the test ramps up.  I can redo this one.

That would be good, thanks.
