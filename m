Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWEOS4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWEOS4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEOS4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:56:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:6367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWEOS4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:56:35 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 20:56:27 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <20060515182855.GB18652@elte.hu> <20060515115208.57a11dcb.akpm@osdl.org>
In-Reply-To: <20060515115208.57a11dcb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152056.27702.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But still, referencing a variable which is implemented in
> arch/i386/kernel/timers/timer_cyclone.c from within arch/i386/kernel/srat.c
> is asking for trouble, no?

Probably, but where would you define it instead? It kind of belongs
into timer_cyclone.c

-Andi

