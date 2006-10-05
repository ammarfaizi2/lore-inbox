Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWJEMy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWJEMy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJEMy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 08:54:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27534 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751407AbWJEMyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 08:54:55 -0400
Subject: Re: 2.6.19-rc1: PATA long delay with AMD driver on init
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610050930.10231.prakash@punnoor.de>
References: <200610050930.10231.prakash@punnoor.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 14:20:17 +0100
Message-Id: <1160054417.1607.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 09:30 +0200, ysgrifennodd Prakash Punnoor:
> Hi,
> 
> I tried the PATA driver for my onboard IDE with one DVD+RW drive connected as 
> master. The driver hangs a long time on probing 

That is sort fo expected for some AMD variants right now as they don't
all have enable bits. Once Tejun's work on drive discovery is in I'll
probably enable it for all PATA chips and that ought to sort it out

