Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVBQXN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVBQXN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVBQXMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:12:32 -0500
Received: from mail.tmr.com ([216.238.38.203]:61445 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261225AbVBQXJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:09:36 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: possible leak in kernel 2.6.10-ac12
Date: Thu, 17 Feb 2005 18:14:03 -0500
Organization: TMR Associates, Inc
Message-ID: <cv37ig$54m$4@gatekeeper.tmr.com>
References: <4213D70F.20104@arrakis.dhis.org><4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1108681105 5270 192.168.12.100 (17 Feb 2005 22:58:25 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200502161835.26047.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> On Wednesday 16 February 2005 06:28 pm, Pedro Venda wrote:
> 
>>Having upgraded most of them to 2.6.10-ac12, one of them showed a linear
>>growth of used memory over the last 7 days, after the first 2.6.10-ac12
>>boot. It came to a point that it started swapping and the swap usage too
>>started to grow linearly.
> 
> 
> cat /proc/slabinfo please. I am also seeing similar symptoms (although that is 
> with 2.6.11-rc4 there is a possibility of a common bug) here and I seem to 
> have linearly growing size-64 in slabinfo.

There has been discussion in another thread about a leak related to 
network activity. You might find more information there, subject 
contains "NOT BIO" if it helps.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
