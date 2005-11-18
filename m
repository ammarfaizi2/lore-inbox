Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbVKRTEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbVKRTEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKRTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:04:34 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:32998 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750776AbVKRTEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:04:34 -0500
Message-ID: <437E264B.8070609@tmr.com>
Date: Fri, 18 Nov 2005 14:06:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arijit Das <Arijit.Das@synopsys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Does Linux has File Stream mapping support...?
References: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arijit Das wrote:
> Ye...I know of tee.
> 
> But the issue here is I have a HUGE Compiler (an Simulation tool) in which thousands of places there are "printf" statements to print messages to STDOUT stream. Now, a requirement came up which needs all those messages thrown to STDOUT also to be logged in a LOGFILE (in addition to STDOUT). Yes, this can be done through tee...but the usage model of the compiler doesn't leave that possibility open for me. 
> 
> So, am looking for a solution inside the Compiler code.

1 - using script allows stdout and file capture, might help

2 - redirect to a fifo, hang tee off the fifo
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
