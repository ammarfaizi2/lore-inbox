Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRC2EKP>; Wed, 28 Mar 2001 23:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRC2EKG>; Wed, 28 Mar 2001 23:10:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132672AbRC2EJv>; Wed, 28 Mar 2001 23:09:51 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: andrew.grover@intel.com (Grover, Andrew)
Date: Thu, 29 Mar 2001 05:10:59 +0100 (BST)
Cc: pavel@suse.cz ('Pavel Machek'), alan@lxorguk.ukuu.org.uk (Alan Cox),
   sfr@canb.auug.org.au, twoller@crystal.cirrus.com,
   linux-kernel@vger.kernel.org
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7D2@orsmsx35.jf.intel.com> from "Grover, Andrew" at Mar 28, 2001 03:12:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14iTm2-00074l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know on ACPI systems you are guaranteed a PM timer running at ~3.57 Mhz.
> Could udelay use that, or are there other timers that are better (maybe
> without the ACPI dependency)? 

We could use that if ACPI was present. It might be worth exploring. Is this
PM timer well defined for accesses  ?
