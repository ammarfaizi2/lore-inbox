Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292398AbSCDOzU>; Mon, 4 Mar 2002 09:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSCDOzK>; Mon, 4 Mar 2002 09:55:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51461 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292398AbSCDOzF>; Mon, 4 Mar 2002 09:55:05 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 15:09:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203040504.AAA05343@ccure.karaya.com> from "Jeff Dike" at Mar 04, 2002 12:04:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hu5x-0007zd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even with address overcommit management, I can fault if I touch pages when
> tmpfs is full but the system is not near overcommit.

That is what mmap defines for a file based mapping yes. Thats a case where
there isnt much else you can do
