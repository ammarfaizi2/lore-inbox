Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTBSD7H>; Tue, 18 Feb 2003 22:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267965AbTBSD7H>; Tue, 18 Feb 2003 22:59:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8381 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267959AbTBSD7H>;
	Tue, 18 Feb 2003 22:59:07 -0500
Date: Tue, 18 Feb 2003 19:52:05 -0800 (PST)
Message-Id: <20030218.195205.85404023.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: sendmsg and IP_PKTINFO
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15954.4693.893707.471216@notabene.cse.unsw.edu.au>
References: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
	<1045552237.4501.8.camel@rth.ninka.net>
	<15954.4693.893707.471216@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Tue, 18 Feb 2003 22:00:37 +1100
   
   It does go on to say that the outgoing packet will be sent over the
   same interface, however I feel that is an illogical conclusion given
   the description of the meaning of the field.
   
   So yes, the current behaviour seems to match part of the
   documentation.  However I argue that the documented behaviour is
   irrational.

Alexey and myself totally disagree.  We have described for you
the intended purpose of this feature.  Please do not try to use
it in some other way, it may prove to be painful :-)
