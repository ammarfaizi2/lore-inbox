Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUEQOHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUEQOHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUEQOHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:07:17 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:4520 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261231AbUEQOHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:07:10 -0400
Date: Mon, 17 May 2004 07:07:05 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517140705.GB29054@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
	hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
	support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516231120.405a0d14.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i_size_write().  But I doubt if bk is using direct-IO in combination with
> MAP_SHARED...

BK doesn't use direct io.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
