Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269391AbRHGUB7>; Tue, 7 Aug 2001 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269392AbRHGUBu>; Tue, 7 Aug 2001 16:01:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31760 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269391AbRHGUBr>; Tue, 7 Aug 2001 16:01:47 -0400
Subject: Re: cpu not detected(x86)
To: andrew.grover@intel.com (Grover, Andrew)
Date: Tue, 7 Aug 2001 21:03:08 +0100 (BST)
Cc: davej@suse.de ('Dave Jones'), nicos@pcsystems.de (Nico Schottelius),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <no.id> from "Grover, Andrew" at Aug 07, 2001 12:40:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UD4G-0003tE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Longer-term, we need to change the kernel to not use the TSC for udelay, but
> to use the PM Timer, if ACPI is going to be monkeying with CPU power states.

That can be done, and may be a help. 

The TSC timer isnt a very good source on many non intel chips that stop it
to get the best power figures. It also helps with SMP because on an SMP box
the tsc values may not calibrate.

Alan
