Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUHXAp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUHXAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUHXAp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:45:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48083 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268159AbUHXAku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:40:50 -0400
Date: Mon, 23 Aug 2004 17:39:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
Cc: alan@lxorguk.ukuu.org.uk, kloczek@rudy.mif.pg.gda.pl,
       usenet-20040502@usenet.frodoid.org, miles.lane@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-Id: <20040823173906.193f9af8.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
	<Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
	<1093174557.24319.55.camel@localhost.localdomain>
	<Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 21:48:57 +0200 (CEST)
Robert Milkowski <milek@rudy.mif.pg.gda.pl> wrote:

> >> [1] Remember: if you want profile some part of code you mast _first_
> >> (re)compile them with profiling enabled. If you wand debug some code
> >
> > OProfile doesn't require this.
> 
> I must admit I don't know OProfile.
> But can you profile already running application without interuption (not 
> to mention stopping it) to it?

Yes, this is exactly what oprofile allows you to do.
Same with things like valgrind.
