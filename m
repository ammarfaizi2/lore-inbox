Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136069AbRDVMZd>; Sun, 22 Apr 2001 08:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136070AbRDVMZY>; Sun, 22 Apr 2001 08:25:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35087 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136069AbRDVMZH>; Sun, 22 Apr 2001 08:25:07 -0400
Subject: Re: Linux 2.4.3-ac12
To: philb@gnu.org (Philip Blundell)
Date: Sun, 22 Apr 2001 13:26:27 +0100 (BST)
Cc: junio@siamese.dhis.twinsun.com, manuel@mclure.org (Manuel McLure),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E14rHJh-0005TP-00@kings-cross.london.uk.eu.org> from "Philip Blundell" at Apr 22, 2001 11:42:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rIwg-0005jI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >If gcc 2.96 uniformly implements it, I'd rather move this
> >backward compatibility definition of __builtin_expect from
> >include/asm-$(arch)/compiler.h to include/asm-generic/
> >somewhere.
> 
> The feature isn't machine dependent, though I don't think all compilers that 
> call themselves "gcc 2.96" support it.  It might be better to test for "2.97".

Why ? It works in the 2.96 snapshots. So 2.96+ is fine.


