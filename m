Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266635AbUG2WHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbUG2WHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUG2WHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:07:09 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49821 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266635AbUG2WHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:07:05 -0400
Subject: Re: OK, anybody have any hints and tips to get an MFM drive
	working again?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <Rogier@wolff.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729201458.GA19252@bitwizard.nl>
References: <20040729201458.GA19252@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091135075.1453.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 22:04:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 21:14, Rogier Wolff wrote:
> I THINK we have a couple of those cards that don't have any 
> interrupts. Would Linux be able to work with those?

The old hd driver should support this in 2.4 and 2.6. Its fair to
say that neither hd.c nor xd.c get much testing nowdays. One of the
biggest problems tends to be finding a machine you can use the old MFM
cards in because any motherboard disk controller will clash.

If you aren't in any hurry you can call handler() from the start of the
timer timeout function if you lack IRQ's.




