Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268509AbRG3LnD>; Mon, 30 Jul 2001 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRG3Lmn>; Mon, 30 Jul 2001 07:42:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268509AbRG3Lmb>; Mon, 30 Jul 2001 07:42:31 -0400
Subject: Re: Linux 2.4.7-ac3
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 30 Jul 2001 12:43:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <23269.996492312@ocs3.ocs-net> from "Keith Owens" at Jul 30, 2001 09:25:12 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15RBSL-0003cB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> >> +spec:	newversion
> >>  	. scripts/mkspec >kernel.spec
> >
> >I only need a new version for a new rpm
> 
> mkspec requires .version, the only rule that creates .version is
> newversion.  If you start from make mrproper, make spec fails.

How about we do

spec:	.version 

then ?

