Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWILMqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWILMqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWILMqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:46:51 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:7889 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965239AbWILMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:46:50 -0400
Date: Tue, 12 Sep 2006 13:46:36 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Eric Sandall <eric@sandall.us>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
Message-ID: <20060912124636.GA31344@srcf.ucam.org>
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <450536D0.4020705@domdv.de> <200609112227.15572.rjw@sisk.pl> <4505E304.7000302@domdv.de> <20060911235920.GA24597@srcf.ucam.org> <45069494.8070904@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45069494.8070904@domdv.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:05:56PM +0200, Andreas Steinmetz wrote:

> Yes, the patch fixes s2ram without acpi_skip_timer_override for me (x86_64).

Excellent.

> There is, however, one difference during boot that may be a hint:
> When booting without acpi_skip_timer_override the following message appears:
> 
> MP-BIOS bug: 8254 timer not connected to IO-APIC

Yeah, that's expected on IXP200 boards.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
