Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbSLRD6u>; Tue, 17 Dec 2002 22:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbSLRD6u>; Tue, 17 Dec 2002 22:58:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266965AbSLRD6t>; Tue, 17 Dec 2002 22:58:49 -0500
Date: Tue, 17 Dec 2002 20:07:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFFED33.2020201@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, on another tangent - Andrew Morton reports that APM is unhappy about
the fact that the fast system call stuff required us to move the segments
around a bit. That's probably because the APM code has the old APM segment
numbers hardcoded somewhere, but I don't see where (I certainly knew about
the segment number issue, and tried to update the cases I saw).

Debugging help would be appreciated, especially from somebody who knows
the APM code.

		Linus

