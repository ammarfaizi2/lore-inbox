Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUHFQqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUHFQqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUHFQne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:43:34 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:48594 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S268191AbUHFQm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:42:59 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408061642.SAA17435@cleopatra.math.tu-berlin.de>
Subject: Re: [PATCH] NetMOS 9805 ParPort interface
In-Reply-To: <200408061641.SAA17413@cleopatra.math.tu-berlin.de>
To: Thomas Richter <thor@math.TU-Berlin.DE>
Date: Fri, 6 Aug 2004 18:42:54 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcello,
 
> > here's a tiny patch against parport/parport_pc.c for kernel 2.4.26.
> > It adds support for the NetMOS 9805 chip, used in several popular
> > parallel port extension cards available here in germany. The patch below
> > has been found working in a beige G3 Mac and a Canon BJC just fine.
> 
> Hi Thomas,
> 
> Looks good, I've queued it for 2.4.28-pre.

Great.

> Care to write a v2.6 version of it ? 

Shouldn't be a major problem. IIRC, the partport_pc is almost identical,
so the change should be trivial. Let's say "Next Monday".

Concerning a similar issues, the same vendor (NetMOS) provides two additional
parport chips besides the 9805 and 9815 (both of which are now supported).

Well, I *do* have the data for them, and the changes should be rather
straight forward, but I don't have the hardware to test them. I could write
up a patch, but that would rather render as "experimental".

Anyone in here with a NetMOS based parallel/serial expansion card not yet
supported? (-;
 
So long,
	Thomas

P.S.: Sorry, forgot to CC' this to the LKML earlier...


