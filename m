Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVCaUHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVCaUHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCaUHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:07:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:15807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261759AbVCaUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:07:08 -0500
Date: Thu, 31 Mar 2005 12:08:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <Pine.LNX.4.58.0503311204050.4774@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0503311206210.4774@ppc970.osdl.org>
References: <200503311953.j2VJrog22170@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0503311204050.4774@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Mar 2005, Linus Torvalds wrote:
> 
> Can you post oprofile data for a run?

Btw, I realize that you can't give good oprofiles for the user-mode
components, but a kernel profile with even just single "time spent in user
mode" datapoint would be good, since a kernel scheduling problem might
just make caches work worse, and so the biggest negative might be visible
in the amount of time we spend in user mode due to more cache misses..

			Linus
