Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTEVDxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 23:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTEVDxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 23:53:10 -0400
Received: from dyn-ctb-210-9-245-156.webone.com.au ([210.9.245.156]:60933 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262473AbTEVDxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 23:53:09 -0400
Message-ID: <3ECC4C3A.9000903@cyberone.com.au>
Date: Thu, 22 May 2003 14:04:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: Rik van Riel <riel@imladris.surriel.com>,
       David Woodhouse <dwmw2@infradead.org>, ptb@it.uc3m.es,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
References: <PEEPIDHAKMCGHDBJLHKGMEIICMAA.rwhite@casabyte.com>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGMEIICMAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert White wrote:

>>From: Rik van Riel [mailto:riel@surriel.com]On Behalf Of Rik van Riel
>>
>
>>So call_EE_ messes with the data structure which call_ER_
>>has locked, unexpectedly because the recursive locking
>>doesn't show up as an error.
>>
>
>Yes and no.  It all hinges on that nonsensical use of "unexpectedly".
>
>(I'll be using fully abstract examples from here on out to prevent the
>function call police from busting me again on a technicality... 8-)
>
Oh come on! Now I won't get into this argument, but you can't win
by saying "if this were implemented in such a way that recursive
locking is required, then recursive locking is required here"!!

Look: I could easily reimplement your snark so it doesn't have to call
the last "whangle" - now see how it can be done completely lockless
with a memory barrier between a and b?

Locking is an implementation issue, and as such I think you'll have
to come up with a real problem or some real code. You must have some
target problem in mind?

Best regards,
Nick

