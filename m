Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDEF51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDEF51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 01:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWDEF51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 01:57:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39061 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751102AbWDEF51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 01:57:27 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
References: <20060404234806.GA25761@verge.net.au>
	<20060404200557.1e95bdd8.rdunlap@xenotime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 23:56:08 -0600
In-Reply-To: <20060404200557.1e95bdd8.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Tue, 4 Apr 2006 20:05:57 -0700")
Message-ID: <m1mzf0in0n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> On Wed, 5 Apr 2006 08:48:08 +0900 Horms wrote:
>
>> Signed-Off-By: Horms <horms@verge.net.au
>> 
>>  machine_kexec.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Can you use diffstat -p1 ?  does git allow/support that option, so that
> more complete filenames are visible?
>
>> b242c77f387d75d1bfa377d1870c0037d9e0c364
>> diff --git a/arch/i386/kernel/machine_kexec.c
> b/arch/i386/kernel/machine_kexec.c
>> index f73d737..beaad58 100644
>> --- a/arch/i386/kernel/machine_kexec.c
>> +++ b/arch/i386/kernel/machine_kexec.c
>> @@ -194,7 +194,7 @@ NORET_TYPE void machine_kexec(struct kim
>>  	 * set them to a specific selector, but this table is never
>>  	 * accessed again you set the segment to a different selector.
>>  	 *
>> -	 * The more common model is are caches where the behide
>> +	 * The more common model is are caches where the behind
>
> Also delete /are/, but that sentence and the previous one still need some
> work, so fixing "behide" isn't a big deal IMO.  However, Eric can decide
> about the patch; he is the kexec maintainer.

Ok.  Randy I think your name is still in Maintainers.  
Should we send Linus a bugfix patch to remove it ?

Eric
