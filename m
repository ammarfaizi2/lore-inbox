Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSLQTko>; Tue, 17 Dec 2002 14:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSLQTkn>; Tue, 17 Dec 2002 14:40:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:3736 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267068AbSLQTkm>;
	Tue, 17 Dec 2002 14:40:42 -0500
Date: Tue, 17 Dec 2002 19:47:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217194708.GA22667@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hpa@transmeta.com
References: <3DFF7399.40708@redhat.com> <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:10:20AM -0800, Linus Torvalds wrote:
 > Intel will fix the stupidities that cause the P4 to be slow at kernel
 > entry. Somebody already mentioned that apparently the newer P4 cores are
 > actually faster at system calls than mine is).

My HT Northwood returns slightly better results than your xeon,
but the syscall stuff still completely trounces it.

(19:38:46:davej@tetrachloride:davej)$ ./a.out 
440.107164 cycles
1152.596084 cycles

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
