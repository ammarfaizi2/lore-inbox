Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSCOVdD>; Fri, 15 Mar 2002 16:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293317AbSCOVcy>; Fri, 15 Mar 2002 16:32:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64016 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293306AbSCOVcp>; Fri, 15 Mar 2002 16:32:45 -0500
Subject: Re: [OOPS] Kernel powerdown
To: andrew.grover@intel.com (Grover, Andrew)
Date: Fri, 15 Mar 2002 21:48:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), reality@delusion.de,
        linux-kernel@vger.kernel.org, andrew.grover@intel.com (Grover Andrew)
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com> from "Grover, Andrew" at Mar 15, 2002 01:30:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lzYv-0004ko-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sure the NMI watchdog shouldn't be an issue :) but IIRC we are masking
> interrupts and doing some delays before turning off, so the NMI watchdog
> might not be liking that? APM doesn't turn off the NMI afaik so why should
> ACPI have to?

Its entirely possible that APM has the same bug but isnt seeing it because
it tends to drop into oblivion before the timer goes off

