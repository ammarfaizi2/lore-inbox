Return-Path: <linux-kernel-owner+w=401wt.eu-S1754848AbWL1NW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbWL1NW4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbWL1NW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:22:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57266 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754848AbWL1NWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:22:55 -0500
Date: Thu, 28 Dec 2006 13:31:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to PM layer break userspace
Message-ID: <20061228133137.409b85d2@localhost.localdomain>
In-Reply-To: <200612232302.06151.david-b@pacbell.net>
References: <20061219185223.GA13256@srcf.ucam.org>
	<200612192114.49920.david-b@pacbell.net>
	<20061222210937.GD3960@ucw.cz>
	<200612232302.06151.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems to me anyone really desperate to put PCI devices into a low
> power mode, without driver support at the "ifdown" level, would be
> able just "rmmod driver; setpci".  

Incorrect for very obvious reasons - there may be two devices driven by
the same driver one up and one down.

Alan
