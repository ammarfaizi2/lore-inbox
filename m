Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVGYRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGYRxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGYRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:53:38 -0400
Received: from mail.tmr.com ([64.65.253.246]:41419 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261345AbVGYRxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:53:38 -0400
Message-ID: <42E5292B.9080703@tmr.com>
Date: Mon, 25 Jul 2005 14:02:19 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
References: <003401c58ea2$4dfd76f0$5601010a@ashley>	<20050722132523.GJ20995@vega.lgb.hu>	<42E517B6.1010704@tmr.com> <20050725190731.0d634842@localhost>
In-Reply-To: <20050725190731.0d634842@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:

>On Mon, 25 Jul 2005 12:47:50 -0400
>Bill Davidsen <davidsen@tmr.com> wrote:
>
>  
>
>>And IMHO Linux is *way* too willing to evicy clean pages of my 
>>programs to use as disk buffer, so that when system memory is full I
>>pay  the overhead of TWO disk i/o's, one to finally write the data to
>>the  disk and one to read my program back in. If free software is
>>about  choice, I wish there was more in the area of how memory is
>>used.
>>    
>>
>
>isn't this tuned enough by "/proc/sys/vm/swappiness" ?
>
>  
>
Let me generate some data points for discussion. But the general answer 
is no, I just want to try to have some numbers to discuss. I also want 
to go back to some 2.4.xx-aa kernels, Andrea had some very nice things 
in his bdflush code, and he was kind enough to explain to me how to tune 
them so I avoided the worst case events.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

