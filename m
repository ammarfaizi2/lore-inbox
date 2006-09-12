Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWILOtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWILOtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWILOtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:49:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:5395 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030218AbWILOtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:49:18 -0400
Message-ID: <4506C9C1.4080902@openvz.org>
Date: Tue, 12 Sep 2006 18:52:49 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Containers <containers@lists.osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Devel] Re: [PATCH] usb: Fixup usb so it uses struct pid
References: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com>	<20060910111249.c2e9c5f2.zaitcev@redhat.com> <m1d5a3ebex.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1d5a3ebex.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pete Zaitcev <zaitcev@redhat.com> writes:

>>> Holding a reference
>>>to a struct pid avoid that problem, and paves the way
>>>for implementing a pid namespace.
>>
>>That may be useful.
>>
>>The patch itself seems straightforward if we can trust your struct
>>pid thingies. If OpenVZ people approve, I don't mind.
> 
> 
> So far I haven't seen any complaints on that score.  None from
> the mainstream kernel folks the vserver guys or the OpenVz guys.
> struct pid itself is in 2.6.18, performing this same function for
> proc, but not all of the helper functions have made it beyond -mm
> yet.  Most of the rest should make it into 2.6.19.
at this stage these patches look fine.

Thanks,
Kirill
