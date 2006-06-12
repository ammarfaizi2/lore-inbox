Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWFLUIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWFLUIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWFLUIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:08:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11220
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932208AbWFLUIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:08:10 -0400
Date: Mon, 12 Jun 2006 13:08:19 -0700 (PDT)
Message-Id: <20060612.130819.56815772.davem@davemloft.net>
To: mingo@elte.hu
Cc: herbert@gondor.apana.org.au, stefanr@s5r6.in-berlin.de,
       Valdis.Kletnieks@vt.edu, jirislaby@gmail.com, akpm@osdl.org,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [patch] undo AF_UNIX _bh locking changes and split lock-type
 instead
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060612084936.GA29516@elte.hu>
References: <20060612064122.GA1101@gondor.apana.org.au>
	<20060612065701.GA24213@elte.hu>
	<20060612084936.GA29516@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 12 Jun 2006 10:49:36 +0200

> Subject: undo AF_UNIX _bh locking changes and split lock-type
> From: Ingo Molnar <mingo@elte.hu>
> 
> this cleans up lock-validator-special-locking-af_unix.patch: instead
> of adding _bh locking to AF_UNIX, this patch splits their
> sk_receive_queue.lock type from the other networking skb-queue locks.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Signed-off-by: David S. Miller <davem@davemloft.net>
