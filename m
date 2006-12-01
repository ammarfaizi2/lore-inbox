Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031677AbWLASuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031677AbWLASuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031707AbWLASuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:50:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62398 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031677AbWLASt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:49:59 -0500
Date: Fri, 1 Dec 2006 18:56:57 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061201185657.0b4b5af7@localhost.localdomain>
In-Reply-To: <1164998179.5257.953.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006 13:36:19 -0500
Ben Collins <ben.collins@ubuntu.com> wrote:

> I'd be willing to bet that most distros have this patch in their kernel.
> One of those things we can't really live without.

This has been suggested various times before. 

| +Before you run away from customising your DSDT, you should note that
| already +corrected tables are available for a fair amount of computers
| on this web-page: +http://acpi.sf.net/dsdt

Generally without copyright permission from the owner of the copyrighted
work in question to have it modified and redistributed.

The whole approach of using filp_open() not the firmware interface
is horribly ugly and does not belong mainstream. 

Alan
