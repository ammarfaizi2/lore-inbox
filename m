Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSFXItq>; Mon, 24 Jun 2002 04:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSFXItp>; Mon, 24 Jun 2002 04:49:45 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:15347 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317436AbSFXIto>; Mon, 24 Jun 2002 04:49:44 -0400
Date: Mon, 24 Jun 2002 10:50:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c 
In-Reply-To: <Pine.LNX.4.44.0206232225410.922-100000@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1020624103237.22509E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Frank Davis wrote:

>   The following patch adds the check for 32-bit DMA mapping functionality 
> for the defxx driver. This is the first step to make this driver compliant 
> with Documentation/DMA-mapping.txt . Please review.

 It's possible DEFPA is not limited to 32-bit addressing.  The board was
designed with Alpha in mind, so it's likely it can address more (and a
brief look at the driver reveals there is room for 48 bits of address in
descriptor entries). 

 Has anyone seen documentation for the board? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

