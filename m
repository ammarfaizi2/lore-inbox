Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUB0X3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUB0X3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:29:25 -0500
Received: from bos-gate3.raytheon.com ([199.46.198.232]:48549 "EHLO
	bos-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S263166AbUB0X3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:29:24 -0500
Message-ID: <403FD2CF.3030701@raytheon.com>
Date: Fri, 27 Feb 2004 15:29:19 -0800
From: Ross Tyler <retyler@raytheon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: how does one disable processor cache on memory allocated with
 get_free_pages?
References: <403E1DF1.9060901@raytheon.com>	 <1077879093.22215.328.camel@gaston>  <403F6413.80800@raytheon.com> <1077921618.23344.40.camel@gaston>
In-Reply-To: <1077921618.23344.40.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Thank you for your response - it is very enlightening.
With this information I think I will be able to make a case not to worry 
about the processor cache.
If I win the argument, it will make my life much easier and my code much 
cleaner.
Thank you.

Regarding my usage of __pa() ...
My hope was that by allocating memory early enough in the boot process, 
I could guarantee that the same physical memory is allocated on every boot.
My experiments have shown that this is the case.
I just use __pa to report this result.

Thanks again!

