Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUEAUsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUEAUsK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUEAUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 16:48:10 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:40608 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262129AbUEAUsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 16:48:06 -0400
Date: Sat, 01 May 2004 13:47:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Marc Boucher <marc@linuxant.com>
cc: Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <17110000.1083444468@[10.10.2.4]>
In-Reply-To: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <6900000.1083388078@[10.10.2.4]> <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> All bugs can be debugged or fixed, it's a matter of how hard it is
>>> to do (generally easier with open-source) and *who* is responsible
>>> for doing it (i.e. supporting the modules).
>> 
>> Yes, exactly. The tainted mechanism is there to tell us that it's not
>> *our* problem to support it. And you deliberately screwed that up,
>> which is why everybody is pissed at you.
> 
> It was already screwed up, and causing unnecessary support burdens
> both on the community ("help! what does tainted mean") and vendors.
> This thread and previous ones have shown ample evidence of that.
> Let's deal with the root problem and fix the messages, as Rik van Riel
> has suggested.
> 
> Most third-party module suppliers have been confronted with the same issue
> and forced to work around it (in other imperfect and sometimes clumsy ways).

Odd that none of them just submitted a patch to fix the "real problem" then.
Sorry, I don't believe that was your only intent.

> One of them redirects the messages to a separate file and appends
> the following notice:
>
>  > ********************************************************************
>  > * You can safely ignore the above message about tainting the kernel.
>  > * It is completely political and means just that the maintainers of
>  > * of modutils package dislike software that is not distributed under
>  > * an open source license.
>  > ********************************************************************

Which is bullshit - It's not political, it's a matter of support. Problems
that appeared to be VM issues, or other things, turned out to be binary
driver issues, which we can't fix, and is a total waste of our time. 
Whether you agree with what we chose to support or not is completely
immaterial - it's not your call.

M.

