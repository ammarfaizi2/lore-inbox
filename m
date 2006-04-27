Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWD0Uhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWD0Uhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWD0Uhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:37:51 -0400
Received: from smtp-out.google.com ([216.239.33.17]:34536 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751646AbWD0Uhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:37:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rGRwHR9FFBMEqPRXpjpHpF+z3s/cATiZ6CkY1opXghVh0Tn0cif3eSXZzOcbNQr9S
	k8Tb7Vb7/Kiy1uI8jgneQ==
Message-ID: <44512B61.4040000@google.com>
Date: Thu, 27 Apr 2006 13:36:49 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
References: <20060427014141.06b88072.akpm@osdl.org>	<p73vesv727b.fsf@bragg.suse.de>	<20060427121930.2c3591e0.akpm@osdl.org>	<200604272126.30683.ak@suse.de>	<20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org>
In-Reply-To: <20060427131100.05970d65.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A lot of these are pretty hard and labor-intensive for people to set up and
> run.  It would be nice, but from a global perspective it's not efficient
> for every member of the kernel team to do all these things.  It's OK I
> think if a few specialists run these tools against lots of people's patches
> all at once.
> 
> Which is basically what we're doing now, although I suspect we could be
> more rigorous about it.

How about if I set up an automated email drop - you email it a patch and 
it will compile test it on a few different configs and run sparse, will 
send you back mail when it's done.

I don't want to boot it, as that gets into security nightmares, but I 
should be able to provide something that does static testing.

> - Matches kernel coding style(!)

E_NEEDS_AUTOMATED_FILTER / lint of some form.

The others all look doable.

The intent would not be that you get burdened with this, but that 
developers send it there before sending it to you. It could even
hand out

Signed-off-by: Magic-testing-framework <basictest@test.kernel.org>

tokens to people who use it ;-)

M.
