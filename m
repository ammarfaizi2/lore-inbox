Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVJUAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVJUAVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVJUAVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:21:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17328 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932560AbVJUAVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:21:42 -0400
Message-ID: <4358348B.9020108@pobox.com>
Date: Thu, 20 Oct 2005 20:21:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: xslaby@fi.muni.cz, alexandre.buisse@ens-lyon.fr,
       linux-kernel@vger.kernel.org, jbenc@suse.cz
Subject: Re: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
References: <20051016154108.25735ee3.akpm@osdl.org>	<20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>	<20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>	<20051020210224.B9D4A22AEB2@anxur.fi.muni.cz>	<43582AA7.4080503@pobox.com> <20051020164538.4c30416f.akpm@osdl.org>
In-Reply-To: <20051020164538.4c30416f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Jiri Slaby wrote:
>> > But here is a problem ieee->perfect_rssi and ieee->worst_rssi is 0 and 0, as
>> > you mentioned -- division by zero...
>> > 
>> > It seems, that it is pulled from your tree, Jeff. Any ideas?
>> > 
>> > thanks,
>>
>> When it was pulled?
> 
> 
> See the first line of the patch, ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/broken-out/git-netdev-all.patch
> 
> it is:
> 
> GIT 43e63da3a056da127f2e58b6ce312974b7205ad6 master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL

ah ok.  I think Jiri's patch is the fix, then.

	Jeff



