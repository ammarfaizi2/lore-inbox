Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271407AbVBEWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbVBEWqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271456AbVBEWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:46:14 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:35989 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S271407AbVBEWqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:46:00 -0500
Date: Sat, 5 Feb 2005 20:45:58 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050205224558.GB3815@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050204103350.241a907a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

For some kernel versions (say, since 2.6.10 proper, all the 2.6.11-rc's,
some -mm trees and also -ac) I have been getting the message "irq 10:
nobody cared!".

The message says that I should pass the irqpoll option to the kernel and
even if I do, I still get the stack trace and the "irq 10: nobody cared!"
message. :-(

The message seems to be related to the Promise PDC20265 driver and it
appeared right after I moved my HDs from my motherboard's VIA controllers
to the Promise controllers. I have an Asus A7V board, with 2 VIA 686a
controllers and 2 Promise PDC20265 controllers.

I already tried enabling and disabling ACPI, but it seems that the problem
just doesn't go away. :-(

I am including the dmesg log of my system with this message. I am CC'ing
the linux-ide list, but I'm only subscribed to linux-kernel. I would
appreciate CC's, if possible.


Thank you very much for any help, Rogério.

P.S.: I am, right now, re-compiling 2.6.11-rc3-mm1 with the extra pass of
kallsyms to see if the problem persists with this release.
-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
