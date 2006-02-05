Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWBEOpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWBEOpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWBEOpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:45:32 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:47236 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750861AbWBEOpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:45:31 -0500
Date: Sun, 5 Feb 2006 14:45:27 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] Driver for reading HP laptop LCD brightness
Message-ID: <20060205144527.GA22751@srcf.ucam.org>
References: <20060205135517.GA21795@srcf.ucam.org> <1139149647.3131.26.camel@laptopd505.fenrus.org> <20060205143446.GA22494@srcf.ucam.org> <1139150502.3131.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139150502.3131.34.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 03:41:42PM +0100, Arjan van de Ven wrote:

> .. and just disabling interrupts isn't going to work? Ok sure there is
> an SMP issue, but a spinlock ought to be able to fix that properly,
> instead of something this evil....

How do we get the BIOS to respect kernel spinlocks? (On the other hand, 
there ought to be a spinlock there to deal with concurrent access in any 
case, I guess)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
