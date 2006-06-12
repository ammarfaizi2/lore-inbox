Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWFLS7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWFLS7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWFLS7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:59:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14025 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751222AbWFLS7T (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:59:19 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number =?utf-8?q?of=09physical_pages_backing?= it
Date: Mon, 12 Jun 2006 19:58:40 +0200
User-Agent: KMail/1.8
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
References: <1149903235.31417.84.camel@galaxy.corp.google.com> <448A762F.7000105@yahoo.com.au> <1150133795.9576.19.camel@galaxy.corp.google.com>
In-Reply-To: <1150133795.9576.19.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121958.41127.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is just the price of those walks that makes smaps not an attractive
> solution for monitoring purposes.

It just shouldn't be used for that. It's a debugging hack and not really 
suitable for monitoring even with optimizations.

For monitoring if the current numa statistics are not good enough
you should probably propose new counters.

-Andi
