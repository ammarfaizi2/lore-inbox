Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263959AbUDFR63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbUDFR63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:58:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12427
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263959AbUDFR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:58:25 -0400
Date: Tue, 6 Apr 2004 19:58:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: racing anon_vma_prepares
Message-ID: <20040406175824.GF2234@dualathlon.random>
References: <20040406170527.GB2234@dualathlon.random> <Pine.LNX.4.44.0404061825010.17386-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404061825010.17386-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:28:04PM +0100, Hugh Dickins wrote:
> On Tue, 6 Apr 2004, Andrea Arcangeli wrote:
> > (I know we could save a few cycles in the unlikely case by doing
> > something more than just anon_vma_prepare but that would render memory.c
> > more complicated, so it's doable but it's a lowpriority matter and I'd
> > be interested in having a smallest possible fix at the moment for
> > pratical reasons). later on we can optimize it further.
> 
> Understood.  Yes, looks okay.  Mainline can improve on it later.

thanks for the review, I appreciate.
