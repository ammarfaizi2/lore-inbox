Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265921AbUFIUO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUFIUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUFIUO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:14:28 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26506 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265921AbUFIUO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:14:27 -0400
Message-ID: <40C76FC8.8030303@tmr.com>
Date: Wed, 09 Jun 2004 16:15:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phy Prabab <phyprabab@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: slow down in 2.6 vs 2.4
References: <20040609033513.76754.qmail@web51807.mail.yahoo.com>
In-Reply-To: <20040609033513.76754.qmail@web51807.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab wrote:
> Hello!
> 
> Over the last two days I have been struggling with
> understanding why 2.6.x kernel is slower than
> 2.4.21/23 kernels.  I think I have a test case which
> demostrates this issue.

Unfortunately this is common. There are a bunch or tunables like 
swappiness and readahead you can adjust, but if anyone has a handle on 
why it's really so slow they don't seem to have gotten a patch out.

On features 2.6 wins, on performance 2.4 seems faster in many cases.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
