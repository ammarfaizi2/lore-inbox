Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWJCWUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWJCWUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWJCWUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:20:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030611AbWJCWUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:20:11 -0400
Date: Tue, 3 Oct 2006 15:10:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Multi sector write transfers
Message-Id: <20061003151034.a7894df8.akpm@osdl.org>
In-Reply-To: <20061001124257.17012.78166.stgit@poseidon.drzeus.cx>
References: <20061001124257.17012.78166.stgit@poseidon.drzeus.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell is moving away from mmc maintainership so we'll need to do
something different here.

The patches look good to my untrained eye, except...

On Sun, 01 Oct 2006 14:42:57 +0200
Pierre Ossman <drzeus@drzeus.cx> wrote:

> SD cards extend the protocol by allowing the host to query a card how many
> blocks were successfully stored on the medium. This allows us to safely write
> chunks of blocks at once.

I recall Russell nacked multisector mmc-writing when it came up six or
twelve months ago.  I don't recall the exact details - lack of trust in
manufacturers supporting it correctly?

Is that concern relevant to this patch?
