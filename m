Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVEJITt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVEJITt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVEJITt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:19:49 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:25448 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261577AbVEJITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:19:47 -0400
Message-ID: <42806EA0.2070501@yahoo.com.au>
Date: Tue, 10 May 2005 18:19:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linuxkernel2.20.sandos@spamgourmet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <42806B78.2020708@home.se>
In-Reply-To: <42806B78.2020708@home.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxkernel2.20.sandos@spamgourmet.com wrote:
>  >Anyway i'll try to catch THE option that make the kernel not so happy
>  >under heavy stress. Stay tuned
> 
> How did this turn out? Any luck? Im seeing this same problem with my 
> e1000, now I did enable rx/tx flow control, I reniced kswapd and I 
> changed vm.min_free_kbytes to 65536, and the problem went away.
> 
> It would be nice with a "cleaner" solution though.
> 

What kernel are you using?

Are you doing a lot of block IO as well?

-- 
SUSE Labs, Novell Inc.

