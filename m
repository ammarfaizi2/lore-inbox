Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbULPRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbULPRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbULPRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:01:09 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11136 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261773AbULPRAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:00:55 -0500
Message-ID: <41C1BF90.2040807@tmr.com>
Date: Thu, 16 Dec 2004 12:02:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
References: <200412041111.16055.gene.heskett@verizon.net>
In-Reply-To: <200412041111.16055.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> At -rc2 my clock kept fairly decent time, but -rc3 is running fast, 
> about 30 seconds an hour fast.
> 
> I've been using ntpdate, is that now officially deprecated?
> 
Running ntpd used to keep the clock dead on, now my 2.6 systems all 
drift one way or the other. I suspect that the system calls used by ntpd 
have changed somehow, but until I find the time to look harder I can't 
say that except as conjecture.

The sad thing is that most of the systems have quite good hardware clocks...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
