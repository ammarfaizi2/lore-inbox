Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVCUCsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVCUCsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 21:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVCUCsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 21:48:10 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:1960 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261475AbVCUCsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 21:48:07 -0500
Message-ID: <423E35E4.1090500@yahoo.com.au>
Date: Mon, 21 Mar 2005 13:48:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: viking <viking@flying-brick.caverock.net.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel hiccups (was USB Mouse Hiccups)
References: <20050321015043.GB7168@flying-brick.caverock.net.nz>
In-Reply-To: <20050321015043.GB7168@flying-brick.caverock.net.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viking wrote:
> Okay - so I see I'm not the only one to see significant slowdowns in 2.6.11.x
> compared to 2.6.10 - guess I'll have to wait until the 4-level table thing
> sorts itself out...
> 
> /me removes foot out of gob.
> 

The 4-level page tables slowdowns don't explain the problems you
are seeing. 2.6.12-rc1 is very close to 2.6.10 speed. The slowdown
we are talking about is on the order of microseconds at process
exit time, and unmap.

So please continue to investigate your problems. I think there may
have been some small CPU scheduler changes between 2.6.10 and
2.6.11 from Con. Seems unlikely that they would be causing your
problems, but that's my suggestion for a starting point.

Thanks,
Nick

