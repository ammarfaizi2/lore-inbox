Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSL1B61>; Fri, 27 Dec 2002 20:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSL1B61>; Fri, 27 Dec 2002 20:58:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265373AbSL1B61>; Fri, 27 Dec 2002 20:58:27 -0500
Message-ID: <3E0D06EF.9050906@zytor.com>
Date: Fri, 27 Dec 2002 18:05:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, terje.eggestad@scali.com,
       Matti Aarnio <matti.aarnio@zmailer.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212241235110.1219-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Note that that was true even before this patch - you cannot use glibc
> without having the default DS/ES settings anyway. I not only checked with
> Uli, but gcc simply cannot generate code that has different segments for
> stack and data, so if you have non-flat segments you had to either

More importantly, SYSENTER hardcodes flat layout.

	-hpa


