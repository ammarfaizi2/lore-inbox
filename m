Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbUDFR2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbUDFR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:28:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39321 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263921AbUDFR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:28:07 -0400
Date: Tue, 6 Apr 2004 18:28:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: racing anon_vma_prepares
In-Reply-To: <20040406170527.GB2234@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404061825010.17386-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Andrea Arcangeli wrote:
> (I know we could save a few cycles in the unlikely case by doing
> something more than just anon_vma_prepare but that would render memory.c
> more complicated, so it's doable but it's a lowpriority matter and I'd
> be interested in having a smallest possible fix at the moment for
> pratical reasons). later on we can optimize it further.

Understood.  Yes, looks okay.  Mainline can improve on it later.

Hugh

