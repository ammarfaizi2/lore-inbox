Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbSJQWqa>; Thu, 17 Oct 2002 18:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262223AbSJQWqa>; Thu, 17 Oct 2002 18:46:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:51206 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262274AbSJQWq1>;
	Thu, 17 Oct 2002 18:46:27 -0400
Message-ID: <3DAF3EF1.50500@domdv.de>
Date: Fri, 18 Oct 2002 00:51:29 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org>	<20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> The more I look at LSM the more and more I dislike it, it sticks it's
> fingers everywhere.  Who is going to use this stuff?  %99.999 of users
> will never load a security module, and the distribution makers are
> going to enable this NOP overhead for _everyone_ just so a few telcos
> or government installations can get their LSM bits?
> 

I'm going to ignore the overhead stated above here. And please take the 
following as a comment/personal opinion you may as well ignore. But I'm 
somewhat irritated, so:

<sarcasm>
So users are dumb in general, why not apply the "Single user linux" 
patch? If you don't remember: http://www.surriel.com/potm/apr2001.shtml
</sarcasm>

Honestly, if you don't offer a patchless option to tighter security you 
can't estimate usage.

Given that LSM becomes a standard part of the kernel it would be easy 
for distros to offer "trusted" installations based on LSM. And in this 
case advanced security will spread.

> This doesn't make any sense to me, including LSM appears to be quite
> against one of the basic maxims of Linux kernel ideology if you ask me
> :-)  (said maxim is: If %99 of users won't use it, they better not
> even notice it is there or be affected by it in any way)

For the next few years 99% of the linux users won't use GBit ethernet, 
so why don't you remove these drivers from the kernel?

If things should be only added to the kernel if there's already 
sufficient users my opinion is that development would come to a grinding 
halt.
-- 
Andreas Steinmetz

