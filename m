Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWIKWYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWIKWYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWIKWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:24:07 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:34976 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965074AbWIKWYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:24:02 -0400
Date: Mon, 11 Sep 2006 23:23:51 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: io-apic - no timer ticks after resume on IXP200
Message-ID: <20060911222351.GA23679@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <200609110746.58548.ak@suse.de> <20060911110530.GA15320@srcf.ucam.org> <200609112202.50756.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609112202.50756.ak@suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 10:02:50PM +0200, Andi Kleen wrote:

> And did it work with a earlier kernel?

No. It works if I hack a call to check_timer into the resume code - I'm 
working through that now to figure out which bit is necessary.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
