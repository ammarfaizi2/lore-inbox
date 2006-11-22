Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755776AbWKVNOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbWKVNOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755777AbWKVNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:14:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:12929 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1755776AbWKVNOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:14:34 -0500
Message-ID: <45644F39.20402@sw.ru>
Date: Wed, 22 Nov 2006 16:23:05 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dmitry Mishin <dim@openvz.org>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>	<45633EDF.3050309@fr.ibm.com> <200611221121.59322.dim@openvz.org> <m1wt5nub08.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wt5nub08.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>We will need this framework to move the network isolation code to the
>>>ns_proxy/net_namespace structure. So if Cedric gives us a empty
>>>framework it is fine, except if someone does not agree with it...
>>>
>>>   -- Daniel.
>>
>>This patch looks acceptable for us.
>>BTW, Daniel, we agreed to be based on the Andrey's patchset. I do not see a 
>>reason, why Cedric force us to make some unnecessary work and move existent 
>>patchset over his interface.
> 
> 
> If you are going to take that attitude.  Where was this conversation?
> 
> It appears several relevant people were not aware of this development
> discussion.  So when it comes up for general review you can expect your
> approach as well as your code to be critiqued.

Eric,

Dim collected the requirements for all the network virtualization approaches:
http://wiki.openvz.org/Containers/Network_virtualization
This was discussed with Daniel and Herbert.

Dim and Daniel just wanted to prepare the patches for this.
So I hope your critique will be constructive as they do a hard job :)

Thanks,
Kirill

