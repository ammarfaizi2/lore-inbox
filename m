Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULQPr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULQPr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbULQPr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:47:59 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:36482 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261360AbULQPrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:47:40 -0500
Message-ID: <41C2FF99.3020908@tmr.com>
Date: Fri, 17 Dec 2004 10:47:37 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Patrick McHardy <kaber@trash.net>, Bryan Fulton <bryan@coverity.com>,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <41C26DD1.7070006@trash.net> <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0412170144410.12579-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Fri, 17 Dec 2004, Patrick McHardy wrote:
> 
> 
>>James Morris wrote:
>>
>>
>>>This at least needs CAP_NET_ADMIN.
>>>
>>
>>It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
>>replace iptables rules :)
> 
> 
> That's what I meant, you need the capability to do anything bad :-)

Are you saying that processes with capability don't make mistakes? This 
isn't a bug related to untrusted users doing privileged operations, it's 
a case of using unchecked user data.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
