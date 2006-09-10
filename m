Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWIJVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWIJVUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWIJVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:20:50 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:2233 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751028AbWIJVUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:20:49 -0400
Date: Sun, 10 Sep 2006 22:20:45 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: io-apic breaks suspend unless acpi_skip_timer_override
Message-ID: <20060910212045.GA9278@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910205803.GA1966@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910205803.GA1966@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 10:58:03PM +0200, Pavel Machek wrote:

> Do you mean suspend-to-RAM? Can you try beeping patch?

Yes, suspend to RAM. I'll look at trying to work out where it blows up, 
though I suspect it's successfully getting back into C code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
