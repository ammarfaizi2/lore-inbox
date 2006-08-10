Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030645AbWHJMR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWHJMR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWHJMR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:17:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17045 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030552AbWHJMRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:17:55 -0400
Subject: Re: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <p733bc5nm5g.fsf@verdi.suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 13:37:44 +0100
Message-Id: <1155213464.22922.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 08:24 +0200, ysgrifennodd Andi Kleen:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > - No support for host-protected-area yet
> 
> Even the support in the old one for that wasn't complete. It didn't
> redo the HPA disabling on resume-from-ram, which made parts of the
> disk not accessible anymore after wakeup. So at least on laptops it
> always had to be disabled anyways.

drivers/ide does not support power management yet. Never has. Some
people are brave and use it as it is rather than fix it.

Alan
