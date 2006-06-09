Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWFIBJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWFIBJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWFIBJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:09:40 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:64152 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S965073AbWFIBJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:09:39 -0400
Date: Thu, 8 Jun 2006 18:09:38 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: George Nychis <gnychis@cmu.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: what processor family does intel core duo L2400 belong to?
In-Reply-To: <4488B159.2070806@cmu.edu>
Message-ID: <Pine.LNX.4.64.0606081757510.18874@twinlark.arctic.org>
References: <4488B159.2070806@cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, George Nychis wrote:

> Hi,
> 
> I am configuring the 2.6.17 kernel for a new thinkpad x60s, and I am wondering
> what processor family to select.  The processor is an Intel Core Duo L2400,
> and the gcc people suggested using the prescott march for cflags.  It is *not*
> a celeron.

the core duo is a pentium-m (well, a pair of p-m).  it's just a branding 
change at this point (an annoying brand name too)... future "core2" have a 
different microarchitecture but i'd still choose pentium-m for early 
kernels on those too... until someone finds some reason to differentiate 
core2.

you can see it's even the same family as pentium-m... see 
<http://sandpile.org/ia32/cpuid.htm> and search for "Intel P6-core" to see 
all the related models in family 6.

-dean
