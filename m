Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVEQNPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVEQNPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVEQNPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:15:21 -0400
Received: from one.firstfloor.org ([213.235.205.2]:19843 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261492AbVEQNPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:15:09 -0400
To: "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is needed to boot 2.6 on opteron dual core
References: <213219CA6232F94E989A9A5354135D2F0936FE@frqexc04.emea.cpqcorp.net>
From: Andi Kleen <ak@muc.de>
Date: Tue, 17 May 2005 15:15:06 +0200
In-Reply-To: <213219CA6232F94E989A9A5354135D2F0936FE@frqexc04.emea.cpqcorp.net> (Sebastien
 Cabaniols's message of "Tue, 17 May 2005 13:48:13 +0200")
Message-ID: <m1br7a804l.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Cabaniols, Sebastien" <sebastien.cabaniols@hp.com> writes:

> Hello lkml,
>
> I am trying to boot a dual core Opteron box with linux 2.6 and it is
> crashing very early (swapper process dies, backtrace shows SMP_boot....
> Stuff) and I was wondering what patches are needed to boot a 2.6 kernel
> on a dual core machine.

It should work with most kernels. Just the level of tuning
during runtime varies (with more tuning the newer the kernel) 
Certainly does for me at least on the AMD reference motherboards/BIOS.

Can you connect a serial console and boot with
earlyprintk=serial,ttyS0,baudrate and post the full crash log?
Please test in advance from a booting kernel if the serial cable etc. really 
work.

-Andi
