Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUIOQKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUIOQKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUIOQJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:09:25 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3739 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266650AbUIOQIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:08:54 -0400
Message-ID: <4148691F.8050701@tmr.com>
Date: Wed, 15 Sep 2004 12:09:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Latest microcode data from Intel.
References: <Pine.LNX.4.44.0409151641430.3504-100000@einstein.homenet><Pine.LNX.4.44.0409151641430.3504-100000@einstein.homenet> <20040915155215.GB24892@redhat.com>
In-Reply-To: <20040915155215.GB24892@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Sep 15, 2004 at 04:43:59PM +0100, Tigran Aivazian wrote:
> 
>  > The microcode driver handles the case of different types of CPUs in an SMP 
>  > system internally. Namely, it selects the appropriate microcode data 
>  > chunks for each CPU and then uploads them correctly to each one. Anyway, 
>  > it only works for Intel processors, so AMD is not in the equation anyway 
>  > (unless I discover that AMD processors support similar feature and enhance 
>  > the driver to support it).

Okay, then there was no need to patch the load program other than "it 
makes me feel better" to use the per-CPU loader if present ;-) I've 
spent more time for less benefit on other software, so I don't feel bad.
> 
> They do support the feature, but AMD folks have stated on this list that they
> don't intend to release any updates other than through their
> conventional means (Ie, BIOS updates).

That's fine as long as you run some approved BIOS, your vendor provides 
timely updates, etc. Having been on the wrong end of a few cases where a 
BIOS "upgrade" broke something, I confess to liking the separation of 
functionality.
> 
> There was a post just 2-3 weeks ago where someone patched microcode.c to
> work on AMD64s.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
