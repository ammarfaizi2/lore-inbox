Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263266AbREaWpi>; Thu, 31 May 2001 18:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbREaWp2>; Thu, 31 May 2001 18:45:28 -0400
Received: from mail.digitalme.com ([193.97.97.75]:47529 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S263266AbREaWpN>;
	Thu, 31 May 2001 18:45:13 -0400
Message-ID: <3B16C9A8.7090402@digitalme.com>
Date: Thu, 31 May 2001 18:46:00 -0400
From: "Trever L. Adams" <vichu@digitalme.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010529
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.5 VM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my opinion 2.4.x is NOT ready for primetime.  The VM has been getting 
worse since 2.4.0, I believe.  Definitely since and including 2.4.3.  I 
cannot even edit a few images in gimp where the entire working set used 
to fit entirely in memory.  The system now locks in some loop (SAK still 
works).

FILE CACHING IS BROKEN.  I don't care who says what, by the time swap is 
half filled, it is time to start throwing away simple caches.  Not wait 
until there is no more memory free and then lock in an infinite loop.

My system has 128 Meg of Swap and RAM.

Trever Adams

