Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWIDKSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWIDKSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIDKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:18:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13030 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751353AbWIDKSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:18:11 -0400
Subject: Re: 2.6.18-rc5-mm1 ich_pata_cbl_detect returns a value despite
	being void
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: jeff@garzik.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060904120405.GC1581@slug>
References: <20060904120405.GC1581@slug>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 11:39:48 +0100
Message-Id: <1157366388.30801.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 12:04 +0000, ysgrifennodd Frederik Deweerdt:
> Hi,
> 
> Compiling 2.6.18-rc5-mm1 issues the following warning:
>   CC      drivers/ata/ata_piix.o
>   drivers/ata/ata_piix.c: In function 'ich_pata_cbl_detect':
>   drivers/ata/ata_piix.c:612: warning: 'return' with a value, in
>   function returning void
> 


Yep already fixed in my tree. Your fix is correct.

Acked-by: Alan Cox <alan@redhat.com>


-- 
VGER BF report: H 0.0204275
