Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUECQXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUECQXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUECQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:23:20 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:4650 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263777AbUECQXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:23:18 -0400
To: corbet@lwn.net (Jonathan Corbet)
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU
References: <20040503150958.6864.qmail@lwn.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 03 May 2004 09:23:17 -0700
In-Reply-To: <20040503150958.6864.qmail@lwn.net>
Message-ID: <52n04pa39m.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 May 2004 16:23:17.0372 (UTC) FILETIME=[F0EDCBC0:01C4312A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jonathan> Andrew had asked:

    Andrew> Can you get a sysrq-p trace?

    Jonathan> There's this little problem in that, to make things go
    Jonathan> wrong, I have to fire up X.  That pretty well hoses the
    Jonathan> display, and an attempt to chvt back to a regular
    Jonathan> console just hangs.  I guess I may have to dig in and
    Jonathan> try to track this one down the hard way; wish I knew
    Jonathan> more about AGP hardware...

Can you get into the machine over the net and use /proc/sysrq-trigger?
(You might need a serial console too depending on how busted things
are)

 - Roland
