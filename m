Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTIGPD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTIGPD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:03:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54926 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263280AbTIGPDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:03:25 -0400
Date: Sun, 7 Sep 2003 16:03:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030907150301.GI19977@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309070322310.17404-100000@devserv.devel.redhat.com> <Pine.LNX.4.44.0309071248510.3022-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309071248510.3022-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> You may perhaps know that the ret count is not important, but I don't
> know that, so wanted to get it right.  (At the time, I also wanted to
> have the list sorted exactly as intended, but now I can't see that the
> relative positions of different keys could matter at all.)

The position of different keys doesn't matter, but the relative
position of identical keys does.

-- jamie

