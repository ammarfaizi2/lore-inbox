Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135273AbRDLTcd>; Thu, 12 Apr 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135275AbRDLTcV>; Thu, 12 Apr 2001 15:32:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135277AbRDLTbW>; Thu, 12 Apr 2001 15:31:22 -0400
Subject: Re: 8139too: defunct threads
To: andrewm@uow.edu.au (Andrew Morton)
Date: Thu, 12 Apr 2001 20:32:53 +0100 (BST)
Cc: stewart@dystopia.lab43.org (Rod Stewart), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au> from "Andrew Morton" at Apr 12, 2001 11:54:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nmpr-0001KH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <slaps head> swapper doesn't know how to reap children, and
> AFAIK there's no way for a kernel thread to fully clean itself
> up.  This is always done by the parent.

Make daemonize() move threads with parent 0 to parent 1

