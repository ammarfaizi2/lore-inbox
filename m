Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbTGHLIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbTGHLIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:08:19 -0400
Received: from smtp2.libero.it ([193.70.192.52]:6357 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265810AbTGHLIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:08:19 -0400
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030708110122.GA10756@vana.vc.cvut.cz>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	 <1057647818.5489.385.camel@workshop.saharacpt.lan>
	 <20030708072604.GF15452@holomorphy.com>
	 <200307081051.41683.schlicht@uni-mannheim.de>
	 <20030708085558.GG15452@holomorphy.com>
	 <1057657046.1819.11.camel@mufasa.ds.co.ug>
	 <20030708110122.GA10756@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1057663430.2449.5.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 13:23:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 13:01, Petr Vandrovec wrote:
> vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
> But it is not tested, I have enough troubles with 2.5.74 without mm patches...
vmnet doesn't compile:

make: Entering directory `/tmp/vmware-config1/vmnet-only'
In file included from userif.c:51:
pgtbl.h: In function `PgtblVa2PageLocked':
pgtbl.h:82: warning: implicit declaration of function `pmd_offset'
pgtbl.h:82: warning: assignment makes pointer from integer without a
cast
make: Leaving directory `/tmp/vmware-config1/vmnet-only'


