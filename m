Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276285AbRJPRQU>; Tue, 16 Oct 2001 13:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRJPRQJ>; Tue, 16 Oct 2001 13:16:09 -0400
Received: from lego.zianet.com ([204.134.124.54]:47377 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S276285AbRJPRP4>;
	Tue, 16 Oct 2001 13:15:56 -0400
Message-ID: <3BCC69E6.403@zianet.com>
Date: Tue, 16 Oct 2001 11:09:58 -0600
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Wierd memory reports in 2.4.12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something isn't right in the reporting of used memory in the 2.4.12 kernel.
Don't know if it has been noticed yet or not. This is an SMP machine
if it has anything to do with it and I have BIGMEM enabled.

Here is a report of 'free'


                           total        used            free    
shared    buffers     cached
Mem:           1029700     752128     277572          0     309204     
477960
-/+ buffers/cache:         -35036    1064736
Swap:           2040244              0    2040244

Notice the negative used cache.

This also makes xosview act in some rather odd behaviour.

Steven

