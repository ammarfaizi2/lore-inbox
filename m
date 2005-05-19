Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVESSgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVESSgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVESSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:36:24 -0400
Received: from fmr19.intel.com ([134.134.136.18]:34488 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261167AbVESSgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:36:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17036.56431.886024.247507@sodium.jf.intel.com>
Date: Thu, 19 May 2005 11:35:27 -0700
To: Andi Kleen <ak@muc.de>
Cc: george@mvista.com, joe.korty@ccur.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
In-Reply-To: <428CC6B5.3070206@mvista.com>
References: <20050518201517.GA16193@tsunami.ccur.com>
	<m1hdh0yu14.fsf@muc.de>
	<428CC6B5.3070206@mvista.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> George Anzinger <george@mvista.com> writes:

>> Andi Kleen wrote: ~>
>>  If you do a new structure for this I would suggest adding a
>> "precision" field (or the same with a different name). Basically
>> ....
> I think the accepted and standard way to do this is to use different
> "clock"s.  For example, in the HRT patch the clocks
> CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR are defined as high
> resolution clocks.

Andi, what is the kind of usage patterns you were envisioning? Do you
know of anyone that would have kind of a hard requirement for doing it
like you suggested?

George's argument makes sense to me, but I wonder if the audio people
would have a rationale against it?

-- 

Inaky

