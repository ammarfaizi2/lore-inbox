Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVI0V0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVI0V0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVI0V0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:26:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23004 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965153AbVI0V0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:26:08 -0400
Message-ID: <4339B8EA.1080303@pobox.com>
Date: Tue, 27 Sep 2005 17:26:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, gregkh <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
References: <20050926201156.7b9ef031.rdunlap@xenotime.net> <20050927044840.GA21108@colo.lackof.org>
In-Reply-To: <20050927044840.GA21108@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> I've no clue why folks thought it was better to ignore
> the IO APIC on UP kernels.

Hysterical raisins:  the -majority- of the early uniprocessor systems 
that claimed IOAPIC support were broken.

	Jeff


