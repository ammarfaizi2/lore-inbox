Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWEaE3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWEaE3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWEaE3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:29:10 -0400
Received: from web51410.mail.yahoo.com ([206.190.38.189]:52308 "HELO
	web51410.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751670AbWEaE3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:29:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rocketmail.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gVlFccTgHDkAAQiQudR+rlrxvd4o/wGdTnLUvtItHxhvw53FakUKoVupYihzxJwE0ENHR/bsD1adeF39hT69D5EICEwDr6GY+HXsgtPIDKfrh7NEWr6hdwmM2kx52vKTjnvIMIfNDpV8kVAzvdn6MLGbzQmw9beCwRDMt+hnYtY=  ;
Message-ID: <20060531042908.10463.qmail@web51410.mail.yahoo.com>
Date: Tue, 30 May 2006 21:29:08 -0700 (PDT)
From: Raghuram <draghuram@rocketmail.com>
Subject: Question about tcp hash function tcp_hashfn()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I needed a hash function (in my TCP related work) for
a project and happened to look at the function used by
TCP implementation in Linux. I searched for some
information about this function but couldn't find much
info. I would appreciate it if someone can provide
details or some pointers in this regard. Specifically,


1) Are there some design considerations/assumptions
behind the algorithm? In general, how was the
algorithm arrived at?

2) What happens if there are collisions? I am assuming
that each entry in the array will point to a linked
list of structures. Is there any limit on the length
of this list? 

I hope it is ok to post questions like these on this
list. Please also CC me as I am not subscribed (at
this point).

Thanks,
Raghu.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
