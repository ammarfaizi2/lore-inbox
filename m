Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755693AbWKQOEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbWKQOEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbWKQOEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:04:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15540 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755665AbWKQOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:04:09 -0500
Date: Fri, 17 Nov 2006 14:09:31 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: regarding VIA quirk fix
Message-ID: <20061117140931.2657fe0e@localhost.localdomain>
In-Reply-To: <455D8B44.2060600@gmail.com>
References: <455D8B44.2060600@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 19:13:24 +0900
Tejun Heo <htejun@gmail.com> wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7415
> 
> Any ideas how to proceed on this bug?

The report appears to be about the earlier patch not the one I did from
reading it. That said I don't see it matters which. 

The only way to track down any remaining ones is to go line by line
through the PCI configuration and understand what we or the bios mixed up
so its pretty tedious but doable assuming the bug isn't in the SATA
driver in the first place. The IRQ routing on the later chips is pretty
rigid so its not too hard to spot a misconfiguration.

Alan
