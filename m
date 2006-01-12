Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWALGl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWALGl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWALGl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:41:26 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:32198 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932687AbWALGl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:41:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 17:41:35 +1100
User-Agent: KMail/1.8.3
Cc: Martin Bligh <mbligh@google.com>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, apw@shadowen.org
References: <43C45BDC.1050402@google.com> <43C5B945.3000903@google.com> <43C5F8C8.60908@mbligh.org>
In-Reply-To: <43C5F8C8.60908@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121741.36042.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 05:35 pm, Martin J. Bligh wrote:
> Martin Bligh wrote:
> >> This is a shot in the dark. We haven't confirmed 1. there is a
> >> problem 2. that this is the problem nor 3. that this patch will fix
> >> the problem. I say we wait for the results of 1. If the improved smp
> >> nice handling patch ends up being responsible then it should not be
> >> merged upstream, and then this patch can be tested on top.
> >>
> >> Martin I know your work move has made it not your responsibility to
> >> test backing out this change, but are you aware of anything being
> >> done to test this hypothesis?
>
> OK, backing out that patch seems to fix it. Thanks Andy ;-)

Yes thanks!

I just noticed the result myself and emailed on another branch of this email 
thread. Gah

Con
