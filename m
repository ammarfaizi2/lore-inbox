Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135868AbRECRzN>; Thu, 3 May 2001 13:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135856AbRECRzF>; Thu, 3 May 2001 13:55:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11272 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135871AbRECRy2>; Thu, 3 May 2001 13:54:28 -0400
Subject: Re: Modules inside modules
To: juan@ansp.br (Juan Carlos)
Date: Thu, 3 May 2001 18:58:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF1998E.B31A6D36@ansp.br> from "Juan Carlos" at May 03, 2001 02:46:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNMo-0005v6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to work with two modules toghter. Is possible to include in the
> one driver one call to another driver?

Yes. A good example of this is to read ne.c and 8390.c. 8390.c is a driver
for the chipset and ne.c is a driver for one of the boards using this
chipset.

That driver shows how to use EXPORT_SYMBOL() as well as callbacks and module
locking

