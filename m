Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSH0UrB>; Tue, 27 Aug 2002 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSH0UrA>; Tue, 27 Aug 2002 16:47:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56589 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317331AbSH0Uq7>; Tue, 27 Aug 2002 16:46:59 -0400
Date: Tue, 27 Aug 2002 13:57:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
In-Reply-To: <1030481129.6203.3.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208271356450.2071-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Aug 2002, Luca Barbieri wrote:
>
> You haven't read the P4 system architecture manual, section 3.11.
> It explicitly says that invlpg ignores the G flag.

Ahh, good. Then my only issue is the mismatched test..

		Linus

