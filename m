Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUG1Wyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUG1Wyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUG1Wx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:53:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267184AbUG1Wrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:47:33 -0400
Date: Wed, 28 Jul 2004 15:45:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040728154523.20713ef1.davem@redhat.com>
In-Reply-To: <16648.10711.200049.616183@wombat.chubb.wattle.id.au>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 08:33:59 +1000
Peter Chubb <peter@chubb.wattle.id.au> wrote:

> But is stat{,64} actually showing up badly in profiles?
> If it's not I don't think it's worth doing *anything* (I can imagine
> loads where it would, e.g., make on a large sourcetree, or running a
> backup)

"find . -type f" is probably the most often run command somewhere
in a shell pipeline when I'm doing kernel work and grepping
around.
