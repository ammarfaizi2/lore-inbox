Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUAPUD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUAPUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:02:46 -0500
Received: from p50821B7E.dip.t-dialin.net ([80.130.27.126]:37255 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265840AbUAPUCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:02:37 -0500
To: "raymond jennings" <highwind747@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
References: <1eI8L-5fS-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 16 Jan 2004 21:01:59 +0100
In-Reply-To: <1eI8L-5fS-9@gated-at.bofh.it> (raymond jennings's message of
 "Fri, 16 Jan 2004 20:50:07 +0100")
Message-ID: <m3ptdjzmq0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"raymond jennings" <highwind747@hotmail.com> writes:

> Is there any value in creating a new filesystem that encodes long
> contiguous blocks as a single block run instead of multiple block
> numbers?  A long file may use only a few block runs instead of many
> block numbers if there is little fragmentation (usually the case).
> Also dynamic allocation of inodes...etc.  The details are long; anyone
> interested can e-mail me privately.

Congratulations. You just reinvented the basic specs of JFS and XFS.

-Andi
