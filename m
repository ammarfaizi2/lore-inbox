Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbSLRUS2>; Wed, 18 Dec 2002 15:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbSLRUS0>; Wed, 18 Dec 2002 15:18:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54286 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267434AbSLRUSW>; Wed, 18 Dec 2002 15:18:22 -0500
Message-ID: <3E00D9EC.2050004@transmeta.com>
Date: Wed, 18 Dec 2002 12:26:20 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Terje Eggestad <terje.eggestad@scali.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.3.95.1021218152425.806A-101000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021218152425.806A-101000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> The number of CPU clocks necessary to make the 'far' or
> full-pointer call by pushing the segment register, the offset,
> then issuing a 'lret' is 33 clocks on a Pentium II.
>
> longcall clocks = 46
> call clocks = 13
> actual full-pointer call clocks = 33

That's not a call, that's a jump.  Comparing it to a call instruction is
meaningless.

	-hpa

