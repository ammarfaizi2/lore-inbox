Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTBSAIP>; Tue, 18 Feb 2003 19:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268106AbTBSAIP>; Tue, 18 Feb 2003 19:08:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63163 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268101AbTBSAIO>;
	Tue, 18 Feb 2003 19:08:14 -0500
Date: Tue, 18 Feb 2003 15:56:51 -0800 (PST)
Message-Id: <20030218.155651.108799644.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: kuznet@ms2.inr.ac.ru, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: sendmsg and IP_PKTINFO
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15954.49970.860809.75554@notabene.cse.unsw.edu.au>
References: <15954.4693.893707.471216@notabene.cse.unsw.edu.au>
	<200302181606.TAA03838@sex.inr.ac.ru>
	<15954.49970.860809.75554@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All you are showing us Neil is that the documentation
is inaccurate.  That snippet you showed me from manual
pages is wrong about sendmsg semantics.

The ifindex you specify does mean "send out this interface".

It is very surprising that this documentation is wrong since
the likely author (Andi Kleen) is smart enough to read the
actual implementation when he writes these things.

And yes, this means, no accurate documentation exists currently.
