Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbVKXH3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbVKXH3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVKXH3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:29:09 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:44987 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030554AbVKXH3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:29:08 -0500
Date: Thu, 24 Nov 2005 07:29:03 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reboot through the BIOS on newer HP laptops
Message-ID: <20051124072903.GA28327@srcf.ucam.org>
References: <20051124052107.GA28070@srcf.ucam.org> <200511240726.16669.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511240726.16669.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 07:26:16AM +0000, Alistair John Strachan wrote:
> On Thursday 24 November 2005 05:21, Matthew Garrett wrote:
> > Newer HP laptops (nc4200, nc6xxx, nc8xxx) hang on reboot with a standard
> > configuration. Passing reboot=b makes them work. This patch adds a DMI
> > quirk that defaults them to this mode, and doesn't appear to have any
> > adverse affects on older HPs.
> 
> Might be better to specify machines that actually have this issue. My NC6000 
> does not have any reboot issues with current or prior kernels, and such a 
> change risks regressing that.

This works fine with the NC6000, and every other HP-Compaq I've been 
able to test it on (which is quite a few). The alternative is really 
quite a long list.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
