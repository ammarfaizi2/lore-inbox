Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVJKQyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVJKQyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVJKQyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:54:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751450AbVJKQyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:54:53 -0400
Date: Tue, 11 Oct 2005 09:54:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
In-Reply-To: <434BEA0D.9010802@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0510110947380.14597@g5.osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
 <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
 <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
 <434BEA0D.9010802@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, Eric Dumazet wrote:
> 
> 2) The unlock sequence is not anymore inlined. It appears twice or three times
> in the kernel.

Ahh, that (2) is the killer, I'd totally forgotten.

Ok, the patch is valid, no arguments.

		Linus
