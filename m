Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUCEI0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCEI0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:26:22 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:25234 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262250AbUCEI0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:26:20 -0500
To: David Eger <eger@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
References: <20040304100503.GA13970@havoc.gtf.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Mar 2004 17:26:10 +0900
In-Reply-To: <20040304100503.GA13970@havoc.gtf.org>
Message-ID: <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@havoc.gtf.org> writes:
> arch/v850/kernel/as85ep1.ld	- WTF? comments in some random charset...

FWIW, the charset is EUC-JP.

Even other files in that same directory aren't consistent, e.g.,
as85ep1.c uses ISO-2022-JP.

[My fault, but it never really registered on my important-enough-to fix
radar (emacs autodetects them all so I never really noticed the
discrepancy).]

-Miles
-- 
We are all lying in the gutter, but some of us are looking at the stars.
-Oscar Wilde
