Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbRG3LPx>; Mon, 30 Jul 2001 07:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268500AbRG3LPo>; Mon, 30 Jul 2001 07:15:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2063 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268497AbRG3LP0>; Mon, 30 Jul 2001 07:15:26 -0400
Subject: Re: Linux 2.4.7-ac3
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 30 Jul 2001 12:16:20 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <16378.996464842@kao2.melbourne.sgi.com> from "Keith Owens" at Jul 30, 2001 01:47:22 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15RB24-0003Xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>  	include/asm \
>  	.hdepend scripts/mkdep scripts/split-include scripts/docproc \
> -	$(TOPDIR)/include/linux/modversions.h
> +	$(TOPDIR)/include/linux/modversions.h \
> +	kernel.spec

Added

> -spec:
> +spec:	newversion
>  	. scripts/mkspec >kernel.spec

I only need a new version for a new rpm

