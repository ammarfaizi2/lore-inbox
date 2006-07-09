Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWGIQFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWGIQFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWGIQFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:05:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932503AbWGIQFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:05:20 -0400
Date: Sun, 9 Jul 2006 09:01:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Miles Lane <miles.lane@gmail.com>
Subject: Re: ACPI_DOCK bug: noone cares
In-Reply-To: <20060709000601.GA13938@stusta.de>
Message-ID: <Pine.LNX.4.64.0607090857440.5623@g5.osdl.org>
References: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
 <20060625200953.GF23314@stusta.de> <a44ae5cd0606251313n5e7654f3t652df65e811325b5@mail.gmail.com>
 <20060625204039.GG23314@stusta.de> <20060709000601.GA13938@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Adrian Bunk wrote:
> 
> Two weeks ago, we had:
> - a bug report
> - a detailed description how to possibly fix this issue
> 
> What we did NOT have was:
> - any reaction by the patch author or any maintainer
>   (although with the exception of Linus, the recipients of the problem
>    description were exactly the same as the ones in this email)
> 
> A few days later, the patch that includes this bug was included in 
> Linus' tree.
> 
> Two weeks later, the bug is still present in both latest -mm and Linus' 
> tree.
> 
> Linus, please do a
>   git-revert a5e1b94008f2a96abf4a0c0371a55a56b320c13e

Fair enough. Reverted.

I think I'll stop accepting any ACPI patches at all that add new features, 
as long as there doesn't seem to be anybody who reacts to bug-reports. We 
don't need ACPI features.

We need somebody who answers when people like Andrew asks about patches to 
support things like memory hotplug (which was also a problem over the last 
weeks). Here's a quote from Andrew from a week or so ago: "repeat seven 
times over three months with zero response.".

It's not worth it to accept new stuff if we know it's not going to get any 
attention ever afterwards.

			Linus
