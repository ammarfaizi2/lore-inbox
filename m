Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUCTNxW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbUCTNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:53:22 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:45573 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263413AbUCTNxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:53:21 -0500
Subject: Re: [CFT,PATCH] cpu detection for 2.6.5-rc1-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <4059F0EF.6070706@colorfullife.com>
References: <4059F0EF.6070706@colorfullife.com>
Content-Type: text/plain
Message-Id: <1079790733.866.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sat, 20 Mar 2004 14:52:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 19:56, Manfred Spraul wrote:
> xHi all,
> 
> 2.6.5-rc1-mm2 contains new slab code that is more memory efficient by 
> setting (and thus reducing) the alignment of the objects based on the 
> actual cpu cache line size. This means that the cpu identification must 
> be done far earlier than before and that caused the boot problems with 
> 2.6.5-mm1.
> 
> Attached is a new proposal against 2.6.5-rc1-mm2 - could you give it a 
> try? It's tested with Pentium 4, bochs (i.e. Intel Pentium) and Athlon 
> XP cpus.

Works fine here where 2.6.5-rc1-mm1 failed miserably ;-)

