Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUDTAaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDTAaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDTA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:29:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:32676 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261981AbUDTA36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:29:58 -0400
Date: Tue, 20 Apr 2004 01:29:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dontneed nonlinear
Message-ID: <20040420002950.GC15220@mail.shareable.org>
References: <Pine.LNX.4.44.0404191848200.30692-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404191848200.30692-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> (But this still leaves mincore unaware of nonlinear vmas: bigger job.)

mincore has other problems too: like giving useless results for
private mappings.

-- Jamie
