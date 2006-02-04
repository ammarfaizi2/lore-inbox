Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWBDMEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWBDMEr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 07:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBDMEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 07:04:47 -0500
Received: from [84.204.75.166] ([84.204.75.166]:35535 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932231AbWBDMEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 07:04:46 -0500
Message-ID: <43E4985D.3070708@yandex.ru>
Date: Sat, 04 Feb 2006 15:04:45 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/sysfs] strange refcounting
References: <1139040821.13125.4.camel@sauron.oktetlabs.ru>
In-Reply-To: <1139040821.13125.4.camel@sauron.oktetlabs.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityutskiy wrote:
> Then, I see /sys/devices/mydev/ in sysfs. I open
> pre-defined /sys/devices/mydev/power/state in userspace and don't close it. 
> 
> Then I run lsmod, and see zero refcount to my module. Well, I run rmmod
> mymod, module is unloaded. 
> 
> Then I close /sys/devices/mydev/power/state, and enjoy segfault. 
> 
I actually forgot to formulate my question: why module's refcount is not 
increased when somebody opens a sysfs file which belongs to this module? 
How to withstan to an unexpected module unload?

Thanks.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
