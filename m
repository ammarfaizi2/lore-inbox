Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVLFVKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVLFVKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVLFVKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:10:10 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:17029 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965036AbVLFVKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:10:09 -0500
Message-ID: <4395FE34.5070406@tmr.com>
Date: Tue, 06 Dec 2005 16:10:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com> <4395A72E.6030006@tmr.com> <20051206175919.GI3084@kroah.com>
In-Reply-To: <20051206175919.GI3084@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Dec 06, 2005 at 09:58:54AM -0500, Bill Davidsen wrote:
> 
>>If a new udev config is needed with every new kernel, why isn't it in
>>the kernel tarball? Is that what you mean by "broken distro
>>configuration?" The info should be in /proc or /sys and not in an
>>external config file, particularly if a different versions per-kernel is
>>needed and people are trying new kernels and perhaps falling back to the
>>old.
> 
> 
> Every distro has different needs for its device naming and groups and
> other intergration into the boot process.  To force all of them to unify
> on one-grand-way-of-doing-things would just not work out at all.

Did I say that. No, I said it would be desirable to provide a working 
config with the kernel, to which something could be symlinked. This no 
more "forces" distributions to do anything than LSB. It would provide a 
default, it would provide something working, and if I didn't like it I 
could change it. But I wouldn't have to try and change thing way up in 
initrd so I can boot one kernel or another...
> 
> Look at all of the variations in the udev tarball between the different
> vendor configurations (we put them in there for other people to base
> their distro off of, if they want to.)
> 
> So providing this config in the kernel will just not work, sorry.

We have standard libraries, header files, system calls, why is a 
standard in this case a bad thing? Actually not even a standard, 
perhaps, a default. It wouldn't make it one bit harder to have custom 
names, for those who believe different is better.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
