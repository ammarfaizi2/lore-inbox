Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129795AbQKGN4Z>; Tue, 7 Nov 2000 08:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKGN4P>; Tue, 7 Nov 2000 08:56:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129673AbQKGN4I>; Tue, 7 Nov 2000 08:56:08 -0500
Subject: Re: Persistent module storage - modutils design
To: vonbrand@inf.utfsm.cl (Horst von Brand)
Date: Tue, 7 Nov 2000 13:55:59 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <200011071330.eA7DUdw26230@pincoya.inf.utfsm.cl> from "Horst von Brand" at Nov 07, 2000 10:30:39 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t9EH-0007Ra-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note! This _has_ to be in the / filesystem so it works before mounting the
> rest of the stuff (if ever). This would rule out /var, and leave just
> /lib/modules/<version>. Makes me quite unhappy...

The /lib filesystem is likely not writable so /var is the right default. 
Any reason it cant be overridden in modules.conf ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
