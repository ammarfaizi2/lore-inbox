Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbTFANkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbTFANkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:40:12 -0400
Received: from lvs00-fl.valueweb.net ([216.219.253.199]:57016 "EHLO
	ams002.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264622AbTFANkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:40:07 -0400
Message-ID: <3EDA0555.6000202@coyotegulch.com>
Date: Sun, 01 Jun 2003 09:53:25 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com>
In-Reply-To: <20030601132626.GA3012@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
>>Proposed conversion:
>>
>>int foo(void)
>>{
>>   	/* body here */
>>}	
> 
> which is why I've always preferred
> 
> int
> foo(void)
> {
> 	/* body here */
> }	
> 
> Is there some reason that I'm missing that the kernel folks like it the other
> way?  

Just my personal opinion:

The return value is part of the function signature; placing it on a 
separate line implies a disconnect between the return value and the rest 
of the declaration.

It's a matter of psychology; your mileage may vary.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

