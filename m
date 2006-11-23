Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933882AbWKWT5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882AbWKWT5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933883AbWKWT53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:57:29 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:17838
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933882AbWKWT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:57:29 -0500
Date: Thu, 23 Nov 2006 11:57:34 -0800 (PST)
Message-Id: <20061123.115734.77406441.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: spyro@f2s.com, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl,
       torvalds@osdl.org
Subject: Re: BUG: 2.6.19-rc6 net/irda/irlmp.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
References: <45657BD4.5040604@f2s.com>
	<9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesper Juhl" <jesper.juhl@gmail.com>
Date: Thu, 23 Nov 2006 14:13:12 +0100

> I reported this yesterday - http://lkml.org/lkml/2006/11/22/137 - It
> is commit 700f9672c9a61c12334651a94d17ec04620e1976 that breaks the
> build.
> 
> Linus: I think that commit should either be reverted or fixed in a
> different way before 2.6.19. As it is right now we have a build
> failure :
> 
> net/built-in.o: In function `irlmp_slsap_inuse':
> net/irda/irlmp.c:1681: undefined reference to `spin_lock_irqsave_nested'
> make: *** [.tmp_vmlinux1] Error 1

Andrew will push the change which will fix this bug, please be
patient.
