Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUIDRUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUIDRUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIDRUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:20:15 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:32217 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264639AbUIDRUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:20:11 -0400
Subject: Re: [2.6.9-rc1 PPC32] drivers/ide/ppc/pmac.c compile error
From: Benoit Dejean <benoit.dejean@placenet.org>
Reply-To: TazForEver@dlfp.org
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1094216856.18057.3.camel@athlon>
References: <1094216856.18057.3.camel@athlon>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Sep 2004 19:20:09 +0200
Message-Id: <1094318409.10820.5.camel@athlon>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 03 septembre 2004 à 15:07 +0200, Benoit Dejean a écrit :
> hello, i get the following error when compiling 2.6.9-rc1
> 
>   CC      .ide/ppc/pmac.o
> drivers/ide/ppc/pmac.c: Dans la fonction « pmac_ide_dma_read »:
> drivers/ide/ppc/pmac.c:1952: error: `ide_dma_intr' undeclared (first use
> in this function)

looks like CONFIG_BLK_DEV_IDEDMA_PCI is not defined ....


-- 
Benoît Dejean
JID: TazForEver@jabber.org
gDesklets http://gdesklets.gnomedesktop.org
LibGTop http://directory.fsf.org/libgtop.html
http://www.paulla.asso.fr

