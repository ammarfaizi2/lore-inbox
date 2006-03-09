Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCIMtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCIMtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCIMtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:49:13 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:47035 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751147AbWCIMtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:49:13 -0500
Message-ID: <4410253E.3070101@sw.ru>
Date: Thu, 09 Mar 2006 15:53:18 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Blunck <jblunck@suse.de>, balbir@in.ibm.com, viro@zeniv.linux.org.uk,
       olh@suse.de, neilb@suse.de, dev@openvz.org, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (updated patch)
References: <20060308145105.GA4243@hasse.suse.de>	<20060309063330.GA23256@in.ibm.com>	<20060309110025.GE4243@hasse.suse.de> <20060309032157.0592153e.akpm@osdl.org>
In-Reply-To: <20060309032157.0592153e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>This change might conflict with the NFS patches in -mm.
>>
>> > 
>>
>> Hmm, right. Andrew, if you want a rediff against -mm just tell me. I'm
>> actually diff'ing against lates linux-2.6.git.
> 
> 
> I'll work it out.
> 
> Are we all happy with this patch now?

I can't see why we fix shrink_dcache_parent() only, why 
shrink_dcache_anon() is totally missed?

Thanks,
Kirill

