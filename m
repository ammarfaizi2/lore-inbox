Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264755AbUEOWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbUEOWMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbUEOWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 18:12:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:60342 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264752AbUEOWMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 18:12:44 -0400
Date: Sat, 15 May 2004 15:09:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: tomita@users.sourceforge.jp, a13a@users.sourceforge.jp,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead PC9800 IDE support
Message-Id: <20040515150930.7af6f87e.rddunlap@osdl.org>
In-Reply-To: <20040515202347.GA22742@fs.tum.de>
References: <200405040135.14688.bzolnier@elka.pw.edu.pl>
	<20040503163220.437c2921.rddunlap@osdl.org>
	<20040515202347.GA22742@fs.tum.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2004 22:23:47 +0200 Adrian Bunk <bunk@fs.tum.de> wrote:

| On Mon, May 03, 2004 at 04:32:20PM -0700, Randy.Dunlap wrote:
| > On Tue, 4 May 2004 01:35:14 +0200 Bartlomiej Zolnierkiewicz wrote:
| > 
| > | 
| > | It was added in 2.5.66 but PC9800 subarch is still non-buildable.
| > | Also this is one big hack and only half-merged.
| > | 
| > 
| > It's fairly simple to make it buildable, but it's still a hack
| > that no one seems to want to support, so I agree, kill it.
| > 
| > Can we kill the rest of it too?
| 
| What's the opinion of the PC-9800 people regarding this issue?
| 
| Is there any work done now or in the near future on the PC-9800 port?

We haven't heard from them.  I have written email to them a few
times (2 or 3), but they haven't replied.

The current PC-9800 implementation is only 1/2 done, and IDE
is very hackish, according to Bart.

And currently X86_PC9800 cannot be selected at all (it's not
there!), so people cannot attempt to build/fix it either
(without fixing that, which I have done, but I don't think it's
worth submitting that patch).

--
~Randy
