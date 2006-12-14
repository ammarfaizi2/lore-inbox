Return-Path: <linux-kernel-owner+w=401wt.eu-S932465AbWLNKzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWLNKzF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWLNKzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:55:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46085 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932465AbWLNKzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:55:04 -0500
Date: Thu, 14 Dec 2006 11:03:24 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bob <spam@homeurl.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Need to enable caches in SMP ? (was Kernel 2.6 SMP very slow with
 ServerWorks LE Chipset)
Message-ID: <20061214110324.780b4bf0@localhost.localdomain>
In-Reply-To: <4580C054.2080902@homeurl.co.uk>
References: <4577AA11.6020906@homeurl.co.uk>
	<4580C054.2080902@homeurl.co.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As per Alan's suggestion I decompressed the kernel source tree with the 
> processes pegged to one CPU then the other, and as he predicted it took 
> vastly longer on one CPU than the other, but I don't know what that 
> implies, or how to fix it.

>From the timing it sounds like one processor cache is disabled which is a
little peculiar to say the least.

Alan
