Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755328AbWKMS4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbWKMS4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbWKMS4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:56:43 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:42985
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1755328AbWKMS4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:56:41 -0500
Message-ID: <4558BF72.2030408@microgate.com>
Date: Mon, 13 Nov 2006 12:54:42 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>	<4558860B.8090908@garzik.org> <45588895.7010501@microgate.com> <m3ejs78adt.fsf@defiant.localdomain>
In-Reply-To: <m3ejs78adt.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> I remember something actually did "won the approval". Don't remember
> the details but I think it included conditional compilation, not
> changing CONFIG_* macros (using different name(s) instead, just not
> starting with "CONFIG_"), and IIRC no changes to Kconfigs.

It's been a while so I don't remember the details
of each suggested fix. The fixes that came closest to
being accepted changed the Kconfigs.

> At least I don't remember any objections to that last version so
> I assumed it's closed.
> 
> Perhaps it was just a dream, who knows :-)

We were in a perpetual state of:

1. supply patch
2. get criticism from new person just joining thread
3. change patch to address criticism
4. goto #1

After a few weeks of that, I gave up.

Since the only problem is compile errors with
a broken kernel configuration, I was willing to
go with the flow and leave it in the current
functional state as it has been for years.

> Nevertheless a fix outlined above would be acceptable, wouldn't it?

It breaks things by forcing the customer to include code
that is not required. That is an issue for embedded systems.

But since we seem stuck in a state where real fixes
are not allowed, and this breakage is constantly reintroduced,
the best thing may be to allow the breakage and I can
provide patches to customers to get things working again.

My preference would be to either fix the warnings (which
I've tried) or leave things in a working state (which
I've also tried), but neither option seems to be allowed.

-- 
Paul Fulghum
Microgate Systems, Ltd.
