Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTAYWVE>; Sat, 25 Jan 2003 17:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTAYWVE>; Sat, 25 Jan 2003 17:21:04 -0500
Received: from air-2.osdl.org ([65.172.181.6]:53390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262420AbTAYWVE>;
	Sat, 25 Jan 2003 17:21:04 -0500
Date: Sat, 25 Jan 2003 14:24:18 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Hugh Dickins <hugh@veritas.com>
cc: <rpjday@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
In-Reply-To: <Pine.LNX.4.44.0301252011420.1784-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0301251418100.14344-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Hugh Dickins wrote:

| On Fri, 24 Jan 2003, Randy.Dunlap wrote:
| > Anyone, where is this kernel size limit coming from?
| >   System is 8384 kB
| >   System is too big. Try using modules.
|
| See pg0 and pg1 in arch/i386/kernel/head.S.  There's no technical
| reason (but well-justified resistance to bloat) why pg2... cannot
| be added, but you might find a few little adjustments needed to
| match elsewhere (if you want your testbuild kernel to boot).

Thanks, Hugh.

Just after I sent that email, I said to myself:
um, maybe something about GDT, related to (max) 1-1 memory mapping.

No, I don't need to boot that kernel.
It was enough of a problem just to build it.

-- 
~Randy

