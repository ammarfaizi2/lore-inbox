Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUH0JIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUH0JIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUH0JIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:08:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64708 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269272AbUH0JEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:04:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.63777.420146.52864@alkaid.it.uu.se>
Date: Fri, 27 Aug 2004 11:04:33 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       willy@w.ods.org
Subject: Re: [PATCH 2.4] fix typo in mm.h introduced 2.4.28-pre2
In-Reply-To: <412E7B8F.5050502@ttnet.net.tr>
References: <412E4F43.9030801@ttnet.net.tr>
	<20040826221229.GB564@alpha.home.local>
	<412E69DC.5050907@ttnet.net.tr>
	<412E7B8F.5050502@ttnet.net.tr>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O.Sezer writes:
 > And I beleive this was a typo? Marcelo, please review and apply.
 > 
 > Ozkan Sezer
 > 
 > --- 28p2/include/linux/mm.h.BAK	2004-08-27 02:39:21.000000000 +0300
 > +++ 28p2/include/linux/mm.h	2004-08-27 02:56:10.000000000 +0300
 > @@ -309,7 +309,7 @@
 >  #define UnlockPage(page)	unlock_page(page)
 >  #define Page_Uptodate(page)	test_bit(PG_uptodate, &(page)->flags)
 >  #ifndef SetPageUptodate
 > -#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags);
 > +#define SetPageUptodate(page)	set_bit(PG_uptodate, &(page)->flags)

ACK. That semi-colon must go.
