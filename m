Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132013AbRCZJ1w>; Mon, 26 Mar 2001 04:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRCZJ1m>; Mon, 26 Mar 2001 04:27:42 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:58527 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131979AbRCZJ1a>; Mon, 26 Mar 2001 04:27:30 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200103260926.LAA08801@sunrise.pg.gda.pl>
Subject: Re: 2.4.2 NINI_PARTITION
To: goldencat@ezdelivery.dnsalias.net
Date: Mon, 26 Mar 2001 11:26:06 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103252254.RAA01850@ezdelivery.dnsalias.net> from "goldencat@ezdelivery.dnsalias.net" at Mar 25, 2001 05:54:03 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"goldencat@ezdelivery.dnsalias.net wrote:"

> msdos.c MINI_PARTITION underclared (first use in this function)
> msdos.c MINI_NR_SUBPARTITIONS' undeclared (first use in this function)
> check msdos.c msdos.h
> can not find MINI_PARTITION/MINI_NR_SUBPARTITIONS

Do you mean MINIX_PARTITION ?
                ^ !!!

1. It is already fixed in 2.4.3-pre1 
2. Just don't compile Minix partition support if you don't need it and
   everything will be OK.

Andrzej
