Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSHZVPg>; Mon, 26 Aug 2002 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHZVPg>; Mon, 26 Aug 2002 17:15:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47806 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318287AbSHZVPf>;
	Mon, 26 Aug 2002 17:15:35 -0400
Date: Mon, 26 Aug 2002 23:22:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-arch load balancing
In-Reply-To: <1030392283.1020.407.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208262321240.10588-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Aug 2002, Robert Love wrote:

> The attached patch implements (optional) per-architecture load balancing
> so we can cleanly implement specialized load balancing behavior for
> NUMA, hyperthreading, etc.

nope, this is not the right approach, at least not for hyperthreading -
i've got a generic approach in my tree, will post a patch soon (tm).

> Please, apply.

please dont ...

	Ingo

