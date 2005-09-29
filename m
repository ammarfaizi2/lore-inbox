Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVI2IyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVI2IyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVI2IyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 04:54:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34689 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751170AbVI2IyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 04:54:09 -0400
Message-ID: <433BABA9.8070908@suse.de>
Date: Thu, 29 Sep 2005 10:54:01 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Alexander Clouter <alex@digriz.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.14] Cpufreq_ondemand sysfs names change
References: <200508232108.26248.blaisorblade@yahoo.it> <200509101536.10307.blaisorblade@yahoo.it> <20050910140148.GC7072@inskipp.digriz.org.uk> <200509271851.36706.blaisorblade@yahoo.it>
In-Reply-To: <200509271851.36706.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:

> *) to rename the flag to ignore_nice_load or ignore_nice_tasks, to avoid 
> burning the user too much. Very few people use it now, but let's help them.

I use it and i have even "fixed" my applications to use the "wrong" flag.

>> My thinking too, its a relatively new feature and when I have looked around
>> very few userland tools even tinker with ondemand so either we do it now or
>> not at all...or rather we do it later and listen to everyone complain :)

so the early birds are doomed? ;-)
I'll bite the bullet if this "flip the meaning" gets in, but i don't
like it. I'll have to check for the kernel version in my userspace code,
then which is generally a bad idea IMO.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
