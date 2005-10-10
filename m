Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVJJSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVJJSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVJJSiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:38:16 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:14055 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751164AbVJJSiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:38:15 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: PCI/IRQ regressions in 2.6.13.2
Date: Mon, 10 Oct 2005 12:38:07 -0600
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20050923171054.GB19763@fi.muni.cz> <20050929144320.GO1901@fi.muni.cz> <20050930102041.GD10110@fi.muni.cz>
In-Reply-To: <20050930102041.GD10110@fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101238.07251.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 4:20 am, Jan Kasprzak wrote:
> 	And what is worse, I have tried to copy the 2.6.14-rc2 with
> CONFIG_ACPI=y to all servers in my cluster, and on two of them
> (different ones than manifest the previous problem) the kernel
> does not boot - and it complains about lost interrupts on /dev/hda
> (dmesg attached - note the "VIA IRQ fixup" and "Unknown interrupt or fault"
> lines around the IDE initialization). Sorry for the previous incomplete
> report, but 2.6.14-rc2 does not work for me with or without CONFIG_ACPI
> (albeit on different hosts).

I've been traveling and not following this.  If this problem hasn't
been resolved yet, can you open a report at bugzilla.kernel.org and
copy me?
