Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUIMJNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUIMJNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUIMJNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:13:11 -0400
Received: from gepard.lm.pl ([212.244.46.42]:54466 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S266460AbUIMJNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:13:07 -0400
Subject: Re: [BUG] kernel BUG at fs/jbd/checkpoint.c:646!
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20040913020143.12983b51.akpm@osdl.org>
References: <1094866100.1770.338.camel@rakieeta>
	 <20040913020143.12983b51.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: o2.pl Sp z o.o.
Message-Id: <1095066672.1754.17.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Sep 2004 11:11:12 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z pon, 13-09-2004, godz. 11:01, Andrew Morton pisze: 
> Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
> >
> >  the following bug is present on kernels: 2.6.7-mm6, 2.6.9-rc1-mm1,
> >  2.6.8.1-mm3. If any testing would be needed I can trigger it here in the
> >  matter of hours.
> > 
> >  Oops from 2.6.8.1-mm3 attached.
> > 
> >  Hope that someone will be able to find a solution for this.
> > 
> >  tia,
> >  Krzysztof
> > 
> > 
> > [2.6.8.1-mm3-oo1  text/plain (2745 bytes)]
> >  Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:646: "transaction->t_forget == NULL"
> 
> You're using data=journal?  If so, you'd best turn it off.
> 
> I'm not able to reproduce this, as usual.  It's on my list of things to ponder.

Yes, that is the case. I hit this bug here every 5 hours or so on 2-3 servers.
Guess I'll turn the data=journal off, for now. If you'd like to get more
info on this I can run modified kernel here if that would help.

Thank you,

Krzysztof.

