Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265188AbUEYWN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbUEYWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265187AbUEYWN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:13:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265188AbUEYWJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:09:59 -0400
Date: Tue, 25 May 2004 15:09:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, riel@redhat.com, andrea@suse.de, torvalds@osdl.org,
       phyprabab@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-Id: <20040525150916.6f385bc9.davem@redhat.com>
In-Reply-To: <20040525214817.GA21112@elte.hu>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
	<20040525141622.49e86eb9.akpm@osdl.org>
	<20040525214817.GA21112@elte.hu>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 23:48:17 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> hm, 1.5K pretty much seems to be the standard. Plus large frames can be
> scatter-gathered via fragmented skbs. Seldom is there a need for a large
> skb to be linear.

Unfortunately TSO with non-sendfile apps makes huge 64K SKBs get
built.
