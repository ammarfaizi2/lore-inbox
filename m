Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWGGVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWGGVeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGGVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:34:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4293 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750834AbWGGVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:34:04 -0400
Subject: Re: 2.6.17-mm6 libata stupid question...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607072122.k67LMjfL004124@turing-police.cc.vt.edu>
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
	 <1152288721.20883.12.camel@localhost.localdomain>
	 <200607072122.k67LMjfL004124@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 22:51:36 +0100
Message-Id: <1152309096.23012.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 17:22 -0400, ysgrifennodd Valdis.Kletnieks@vt.edu:
>         ap->cbl = ATA_CBL_PATA40;
> 
> Guess that explains that, unless the chipset actually *can* do 80-pin
> and has an 80-pin cable (which would be surprising because apparently
> none of the other piix variants can...)

Thats a bug.  ich_pata_100: 3  should have port_ops of ich_port_ops. Try
with that fixed.

Alan

