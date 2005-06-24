Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVFXOSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVFXOSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVFXOSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:18:52 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:41138 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262734AbVFXOOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:14:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Date: Sat, 25 Jun 2005 00:14:26 +1000
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
References: <208690000.1119330454@[10.10.2.4]> <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]>
In-Reply-To: <51900000.1119622290@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506250014.26504.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2005 00:11, Martin J. Bligh wrote:
> --Andrew Morton <akpm@osdl.org> wrote (on Tuesday, June 21, 2005 13:03:44 
-0700):
> > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >> Or I guess it's binary chop
> >>  search amongst sched patches (or at least the ones that are new in
> >>  this -mm ?)
> >
> > Yes please.
>
> OK, still broken with the last 3 backed out, but works with the last
> 4 backed out. So I guess it's scheduler-cache-hot-autodetect.patch
> that breaks it. Con just sent me something else to try to fix it in order
> to run next ... will do that.

Sorry, that patch I sent isn't a fix for any known problem, it's another tweak 
to my code. If you have breakage elsewhere don't waste your time with my code 
just yet.

Cheers,
Con
