Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVHVWbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVHVWbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVHVWbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:31:05 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:27149 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751411AbVHVWbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:31:00 -0400
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Binding a thread (or specific process) to a designated CPU
References: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Mon, 22 Aug 2005 18:25:05 -0400
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA096FF8B@chicken.machinevisionproducts.com> (Brian D. McGrew's message of "Mon, 22 Aug 2005 14:56:47 -0700")
Message-ID: <m27jed1uf2.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian D. McGrew" <brian@visionpro.com> writes:

> Good morning,
>
> Using FC3 or FC4 with the 2.6.9 or later kernel, we're looking for a way
> to bind a thread (or an entire process) to a designated CPU.  We're
> using dual processor systems as well as P4 with HT and Xeons so all of
> our boxes either have two CPU's or 'appear' to have two.
>
> I want to be able, in my C++ code to designate a specific thread to a
> specific processor.  I've heard rumors that with the 2.6 kernel this is
> now possible???

Look into sched_setaffinity() and friends.

-Doug
