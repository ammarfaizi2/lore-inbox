Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTLER3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLER3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:29:17 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:36000 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S264245AbTLER3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:29:16 -0500
Date: Fri, 5 Dec 2003 09:29:15 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Rootkit queston
In-Reply-To: <1070313094.11356.6.camel@midux>
Message-ID: <Pine.LNX.4.58.0312050927080.25927@twinlark.arctic.org>
References: <1070313094.11356.6.camel@midux>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Dec 2003, Markus Hästbacka wrote:

> I've been paranoid after I heard that the debian project got
> "rootkitted", I ran chkrootkit, and it said that it's possible that I
> have a LKM rootkit installed, but the website told me that it's possible
> that the LKM test gives wrong information with recent kernels (Running
> 2.4.22 now).

chkrootkit's lkm test is fooled by kernel threads... and if your system is
under heavy fork/exit load it'll result in some false lkm positives as
well.  it shouldn't be hard to fix the first problem (in chkrootkit), but
the second has no real solution.

-dean
