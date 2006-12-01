Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936203AbWLATqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936203AbWLATqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936176AbWLATqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:46:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58831 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031612AbWLATqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:46:32 -0500
Date: Fri, 1 Dec 2006 19:53:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061201195337.39ed9992@localhost.localdomain>
In-Reply-To: <1165001705.5257.959.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
	<20061201185657.0b4b5af7@localhost.localdomain>
	<1165001705.5257.959.camel@gullible>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The whole approach of using filp_open() not the firmware interface
> > is horribly ugly and does not belong mainstream. 
> 
> What about the point that userspace (udev, and such) is not available
> when DSDT loading needs to occur? Init hasn't even started at that
> point.

Does that change the fact it is ugly ?

Alan
