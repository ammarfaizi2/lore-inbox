Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292943AbSB0WWd>; Wed, 27 Feb 2002 17:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292966AbSB0WWG>; Wed, 27 Feb 2002 17:22:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292805AbSB0WV1>; Wed, 27 Feb 2002 17:21:27 -0500
Subject: Re: ext3 and undeletion
To: jstrand1@rochester.rr.com (James D Strandboge)
Date: Wed, 27 Feb 2002 22:33:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1014848170.18953.57.camel@hedwig.strandboge.cxm> from "James D Strandboge" at Feb 27, 2002 05:16:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gCdF-00069W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /root/.bashrc /etc/fstab'), wouldn't 'cp' (or most any other app) first
> unlink the first file (/etc/fstab), then create and write the new one?

Unlikely - It will truncate it and write over it. Try strace cp 8)
