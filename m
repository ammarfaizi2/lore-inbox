Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTAYULd>; Sat, 25 Jan 2003 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTAYULd>; Sat, 25 Jan 2003 15:11:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48177 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261963AbTAYULd>; Sat, 25 Jan 2003 15:11:33 -0500
Date: Sat, 25 Jan 2003 20:22:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: rpjday@mindspring.com, <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
In-Reply-To: <Pine.LNX.4.33L2.0301241741470.9816-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0301252011420.1784-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Randy.Dunlap wrote:
> Anyone, where is this kernel size limit coming from?
>   System is 8384 kB
>   System is too big. Try using modules.

See pg0 and pg1 in arch/i386/kernel/head.S.  There's no technical
reason (but well-justified resistance to bloat) why pg2... cannot
be added, but you might find a few little adjustments needed to
match elsewhere (if you want your testbuild kernel to boot).

Hugh

