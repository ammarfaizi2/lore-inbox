Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTD0DKt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 23:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTD0DKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 23:10:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19467 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263322AbTD0DKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 23:10:48 -0400
Date: Sat, 26 Apr 2003 20:22:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
In-Reply-To: <20030427051451.43064@colin.muc.de>
Message-ID: <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Apr 2003, Andi Kleen wrote:
> 
> Hmm. I thought using the Fibonaci sequence for this was clever :-)

That's not the fibonacci sequence, that's just a regular sigma(i)  
(i=1..n) sequence. And if you were to generate the sequence numbers at
compile-time I might agree with you, if you also were to avoid using 
inline asms.

		Linus

