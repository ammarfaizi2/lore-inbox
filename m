Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUBVCq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUBVCq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:46:29 -0500
Received: from holomorphy.com ([199.26.172.102]:12549 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261649AbUBVCq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:46:28 -0500
Date: Sat, 21 Feb 2004 18:46:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222024623.GE703@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <20040222021710.GD703@holomorphy.com> <4038162C.7080301@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038162C.7080301@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I think they're in -mm, and I'd call the vfs slab cache shrinking stuff
>> a vfs issue anyway because there's no actual VM content to it, apart
>> from the code in question being driven by the VM.

On Sun, Feb 22, 2004 at 01:38:36PM +1100, Nick Piggin wrote:
> Yes they're in -mm and in dire need of more testing.
> The indented audience are people who's machines are swapping a lot,
> but ensuring they don't break more common cases isn't a bad idea.

The only symptom I'm having is running out of filp's shortly after boot.
I'm not having any performance issues. In fact, I'll send an unrelated
post out about how happy I am about performance. =)


-- wli
