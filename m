Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTIARWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTIARWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:22:15 -0400
Received: from webmail.netapps.org ([12.162.17.40]:39631 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263112AbTIARWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:22:13 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Matt Porter <mporter@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829103943.A18608@home.com>
	<20030901060040.GH748@mail.jlokier.co.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 01 Sep 2003 10:22:02 -0700
In-Reply-To: <20030901060040.GH748@mail.jlokier.co.uk>
Message-ID: <52oey4ifut.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2003 17:22:02.0781 (UTC) FILETIME=[8F07C4D0:01C370AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matt> PPC440GX, non cache coherent, L1 icache is VTPI, L1 dcache
    Matt> is PTPI

    Jamie> The cache looks very coherent to me.

Matt (like me) is probably just used to thinking of the IBM PPC 440
chips as non-coherent because they are not cache coherent with respect
to external bus masters (eg they don't snoop the PCI bus).  Of course,
this is a different type of coherency from what you are measuring.

 - Roland
