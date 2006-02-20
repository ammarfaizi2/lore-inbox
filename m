Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWBTL27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWBTL27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWBTL27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:28:59 -0500
Received: from [217.147.92.49] ([217.147.92.49]:42660 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932609AbWBTL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:28:58 -0500
Date: Mon, 20 Feb 2006 11:28:19 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jaya Kumar <jayakumar.acpi@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Message-ID: <20060220112819.GA4837@srcf.ucam.org>
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com> <20060220102639.GA4342@srcf.ucam.org> <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com> <20060220110145.GB4489@srcf.ucam.org> <756b48450602200325v28f0300cu8b4845ab9dba9a4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756b48450602200325v28f0300cu8b4845ab9dba9a4c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 07:25:26PM +0800, Jaya Kumar wrote:

> I have some questions then.
> 1. Are Patrick's acpi driver model changes considered to be a more
> final approach that standardize everyone to some sysfs based interface
> to userspace?

I don't believe so. Backlight drivers will still need to register as 
such independently. It's just somewhat orthogonal.

> Ok. I wish I'd known before. I scanned the mailing list before
> mbarking on this to see if any issues were raised with toshiba and
> asus driver code and didn't see anything. FWIW, my powers of mind
> reading only work on Fridays. :-)

I started sending patches a couple of weeks ago, but I need to tidy them 
up to apply against latest -mm.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
