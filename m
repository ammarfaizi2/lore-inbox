Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286247AbRLTNay>; Thu, 20 Dec 2001 08:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286250AbRLTNao>; Thu, 20 Dec 2001 08:30:44 -0500
Received: from jester.ti.com ([192.94.94.1]:18925 "EHLO jester.ti.com")
	by vger.kernel.org with ESMTP id <S286247AbRLTNad>;
	Thu, 20 Dec 2001 08:30:33 -0500
Message-ID: <3C21E7F1.3040406@ti.com>
Date: Thu, 20 Dec 2001 14:30:25 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: minimizing swap usage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

Can someone give me a pointer to how I can avoid somethign like this:

foo@bar]$ free -m
	    total       used       free     shared    buffers     cached
Mem:           249        245          4          0          6       136
-/+ buffers/cache:        102        147
Swap:          243         89        153

What's with all the caching when my apps crawl because it's swapping so 
much ? I've tried to adjust /proc/vm/kswapd parameters but that doesn't 
seem to help..I'd like to postpone the swapping until its almost out of 
physical memory..

best regards

Christian



