Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265835AbSKBA2T>; Fri, 1 Nov 2002 19:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbSKBA2T>; Fri, 1 Nov 2002 19:28:19 -0500
Received: from dp.samba.org ([66.70.73.150]:27267 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265835AbSKBA1Y>;
	Fri, 1 Nov 2002 19:27:24 -0500
Date: Sat, 2 Nov 2002 06:22:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] performance counters 3.1 for 2.5.45 [1/4]: x86 support
Message-ID: <20021101192201.GC2746@krispykreme>
References: <200210312310.AAA07606@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210312310.AAA07606@kim.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This patch set contains an updated version of the performance
> monitoring counters driver I sent before.

Any chance that this and oprofile could share a common base? We are
interested in both oprofile and straight performance counting on
ppc64 and Id prefer not to implement the arch bits twice.

Anton
