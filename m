Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWCHE6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWCHE6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWCHE6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:58:50 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34108 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751278AbWCHE6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:58:50 -0500
Date: Wed, 08 Mar 2006 13:58:40 +0900 (JST)
Message-Id: <20060308.135840.69058042.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060307180907.GA13577@linux-mips.org>
References: <20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
	<20060307180907.GA13577@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 7 Mar 2006 18:09:07 +0000, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Below's fix results in exactly the same code size on all
ralf> compilers and configurations I've tested it.

ralf> I also have another more elegant fix which as a side effect
ralf> makes get_unaligned work for arbitrary data types but it that
ralf> one results in a slight code bloat:

I tested the patch attached on several MIPS kernel (big/little,
32bit/64bit) with gcc 3.4.5.  In most (but not all) case, Ralf's fix
resulted better than the previous fix.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
