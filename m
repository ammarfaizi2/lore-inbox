Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCCB2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCCB2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCCBYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:24:13 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:52383 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261200AbVCCBXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:23:21 -0500
Message-ID: <422666F9.4040807@yahoo.com.au>
Date: Thu, 03 Mar 2005 12:23:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
In-Reply-To: <20050302162312.06e22e70.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Jeff Garzik <jgarzik@pobox.com> wrote:
>
>> IMO too confusing.
>>
>
> 2.6.even: bugfixes only
> 2.6.odd: bugfixes and features.
>
> That doesn't even confuse me!
>

I actually second Matt's request; -RCs à la 2.4.

Then your above becomes:
2.6.x-rc: bugfixes only
2.6.x-pre: bugfixes and features

And then that doesn't confuse end users either.

Not to mention that if we adopt a strict release candidate release style
(ie. last -rc is renamed to release), then you get to move some of the
burden of testing to the end user. Hopefully that will encourage more
people to test -rcs rather than "tricking" them into doing the testing.

And if we really make an effort to only do the first -rc with the
expectation that it will be the *only* one, then that will be a pretty
good incentive to test.

Nick


