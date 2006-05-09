Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWEIOkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWEIOkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWEIOkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:40:04 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:5072 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751065AbWEIOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:40:02 -0400
Message-ID: <4460A94A.10905@tmr.com>
Date: Tue, 09 May 2006 10:38:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
References: <445B7EF0.6090708@zytor.com> <p733bfo5ol1.fsf@bragg.suse.de>
In-Reply-To: <p733bfo5ol1.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> The recent fix for the AMD FXSAVE information leak had a problematic
>> side effect.  It introduced an entry in the x86 features vector which
>> is a bug, not a feature.
> 
> It's a non issue because it affects all AMD CPUs (except K5/K6).
> You'll never find a system where only some CPUs have this problem.
> 
The initial argument is dead on, bugs should be either presented as a
"fixed" feature, or there could (should?) be a bugs vector which could
be or'd. It's at least possible that AMD might fix this some time.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


