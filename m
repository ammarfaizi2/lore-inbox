Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVGGAoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVGGAoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGGAmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 20:42:31 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:33507 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262370AbVGGAkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 20:40:41 -0400
Message-ID: <42CC79F4.5010605@am.sony.com>
Date: Wed, 06 Jul 2005 17:40:20 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH] Fix posix_bump_timer args
References: <20050706171756.258d4f33.rdunlap@xenotime.net>
In-Reply-To: <20050706171756.258d4f33.rdunlap@xenotime.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Wed, 06 Jul 2005 11:26:31 -0700 Geoff Levand wrote:
> 
> | This patch makes posix_bump_timer() consistent with common convention 
> | by expecting a pointer to the structure be passed.
> | 
> | Please apply.
> 
> Does it matter other than for consistency?
> 
> E.g., in a large system with thousands of timers, it seems that it
> could (at least theoretically) have a negative impact by using a
> pointer dereference instead of a known fixed address.
> or am I just imagining that?
> 

I pulled this out of the HRT patches.  In general it was agreed that 
the change is for the best.

-Geoff
