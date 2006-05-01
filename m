Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWEAVfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWEAVfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWEAVfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:35:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2852 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932273AbWEAVfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:35:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=vCruGuQqnKdUlZMmhUuu/QeXiM51s11ufd24MyXL7r6yxaw9mqRqtrrxyZ5BQa4/O
	wfR3JiClkPBbYv2z/motA==
Message-ID: <44567F09.9080902@google.com>
Date: Mon, 01 May 2006 14:35:05 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valerie Henson <val_henson@linux.intel.com>
CC: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de> <20060427121930.2c3591e0.akpm@osdl.org> <200604272126.30683.ak@suse.de> <20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com> <445220AB.9000606@grupopie.com> <20060501212051.GG32385@goober>
In-Reply-To: <20060501212051.GG32385@goober>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson wrote:
> On Fri, Apr 28, 2006 at 03:03:23PM +0100, Paulo Marques wrote:
> 
>>Martin Bligh wrote:
>>
>>>>[...]
>>>
>>>I don't want to boot it, as that gets into security nightmares, but I 
>>>should be able to provide something that does static testing.
>>
>>Actually, booting might not be that bad using a virtual machine with qemu.
> 
> 
> Honestly, the security nightmare begins with the compile.  A patch to
> the build system can result in arbitrarily insecure commands being run
> during the compile - way easier than doing something that affects the
> compiled kernel.  A machine doing automatic compiles of untrusted
> patches should be viewed as completely sacrificial from the beginning.

True - good point ... but it's easier to chroot jail. And I'm lazy ;-)
If anyone wants to make autotest (http://test.kernel.org/autotest)
support some sort of virtual boot via creating a UML instance or
something, that'd be great. But I won't hold my breath ;-)

M.
