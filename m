Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266583AbRG1Mf1>; Sat, 28 Jul 2001 08:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRG1MfR>; Sat, 28 Jul 2001 08:35:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62993 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266583AbRG1MfB>; Sat, 28 Jul 2001 08:35:01 -0400
Subject: Re: 2.4.7-ac2: jffs2.o compile error
To: fdavis@andrew.cmu.edu (Frank Davis)
Date: Sat, 28 Jul 2001 13:36:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, fdavis112@juno.com
In-Reply-To: <Pine.GSO.4.21L-021.0107280130230.22991-100000@unix13.andrew.cmu.edu> from "Frank Davis" at Jul 28, 2001 01:35:22 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QTKQ-0007Xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.7-ac2/kernel/fs/jffs2/jffs2.o
> depmod:  up_and_exit
> 
> up_and_exit is used in fs/jffs2/background.c 

Yes. It needs changing to use complete_and_exit. 

Alan
