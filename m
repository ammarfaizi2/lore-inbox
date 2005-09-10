Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVIJAQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVIJAQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVIJAQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:16:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54948 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030402AbVIJAQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:16:48 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Sat, 10 Sep 2005 02:16:45 +0200
User-Agent: KMail/1.8
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Hugh Dickins <hugh@veritas.com>,
       Jan Beulich <JBeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200509091351_MC3-1-A9A7-F01A@compuserve.com>
In-Reply-To: <200509091351_MC3-1-A9A7-F01A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509100216.46247.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 19:50, Chuck Ebbert wrote:
> In-Reply-To: <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>
>
> On Fri, 9 Sep 2005 at 12:14:38 +0100 (BST), Hugh Dickins wrote:
> > On Fri, 9 Sep 2005, Andi Kleen wrote:
> > > It won't give more accurate backtraces, not even on i386 because
> > > show_stack doesn't have any code to follow frame pointers.
> >
> > Ah, right.
>
> What's this for, then? (arch/i386/kernel/traps.c line 116)

Ok someone added it when I wasn't looking. It certainly wasn't there some time
ago. However the point stands that x86-64 doesn't have such code.

-Andi

