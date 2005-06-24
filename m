Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbVFXXeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVFXXeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVFXXeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:34:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35013 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263220AbVFXXeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:34:08 -0400
Message-ID: <42BC986A.4050807@pobox.com>
Date: Fri, 24 Jun 2005 19:34:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] I2O: Lindent run and replacement of printk through osm
 printing functions
References: <200506241709.j5OH98vv000983@hera.kernel.org> <42BC888E.3010600@pobox.com> <42BC93EC.8030909@shadowconnect.com>
In-Reply-To: <42BC93EC.8030909@shadowconnect.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel wrote:
> Hello,
> 
> Jeff Garzik wrote:
> 
>> Linux Kernel Mailing List wrote:
>>
>>> tree da7e51e7204625f21371eac23a931f4fe479e9db
>>> parent 9e87545f06930c1d294423a8091d1077e7444a47
>>> author Markus Lidel <Markus.Lidel@shadowconnect.com> Fri, 24 Jun 2005 
>>> 12:02:23 -0700
>>> committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 24 Jun 2005 
>>> 14:05:29 -0700
>>> [PATCH] I2O: Lindent run and replacement of printk through osm 
>>> printing functions
>>> Lindent run and replaced printk() through the corresponding osm_*() 
>>> function
>>
>> Please don't combine ANY code changes with an Lindent patch.
> 
> 
> Also if there is no functional change, only cosmetical (the osm_*() 
> function just mappes to printk(*, ...))?

Yes.  An Lindent patch needs to contain absolutely nothing else, not 
even documentation changes.

The rationale is that it is extremely difficult for reviewers to review 
your non-Lindent changes, because they are so obscured by Lindent.

In the past, one person even hid a [valid] security fix inside an 
Lindent patch.

	Jeff



