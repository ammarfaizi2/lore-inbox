Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVLBDEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVLBDEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLBDEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:04:45 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:54729 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750704AbVLBDEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:04:44 -0500
Message-ID: <438FB9CA.9050004@bigpond.net.au>
Date: Fri, 02 Dec 2005 14:04:42 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, sam@ravnborg.org
Subject: Re: [q] make modules_install as non-root?
References: <2cd57c900512011823v153a6763t@mail.gmail.com>	 <438FB582.3090002@bigpond.net.au> <2cd57c900512011859v7f0db82fg@mail.gmail.com>
In-Reply-To: <2cd57c900512011859v7f0db82fg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Dec 2005 03:04:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 2005/12/2, Peter Williams <pwil3058@bigpond.net.au>:
> 
>>Coywolf Qi Hunt wrote:
>>
>>>Hello people,
>>>
>>>I wrote my own installkernel so I can do `make install' as non-root
>>>with the help of sudo. But how can we get to do `make modules_install'
>>>as non-root with sudo as well?
>>>
>>>The works of modules_install seem scattered over several places.  Is
>>>it a nice idea to factor out an *installmodules* script for `make
>>>modules_install' to invoke?
>>>
>>>ps:
>>>Linus recommend us to build as non-root and install as root.
>>>I ask if we should install as non-root too.
>>
>>Personally, I just use "sudo make install" or "sudo make
>>modules_install" to do installations as an ordinary user.  No need for
>>special scripts or modifications to the build procedure.
> 
> 
> That's rather insecure. You have to add /usr/bin/make in your sudoers,
> then an malicious Makefile could do harm.

Only if you run it with sudo.

> I'm being paranoid. But we
> all are since we avoid to use root.
> --
> Coywolf Qi Hunt
> http://sosdg.org/~coywolf/


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
