Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWBJNTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBJNTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWBJNTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:19:34 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:21396 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751163AbWBJNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:19:32 -0500
Date: Fri, 10 Feb 2006 13:19:14 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210131914.GA7609@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org> <20060209085344.GF16052@boogie.lpds.sztaki.hu> <20060210122131.GC4974@elf.ucw.cz> <20060210131337.GD11740@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210131337.GD11740@boogie.lpds.sztaki.hu>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 02:13:38PM +0100, Gabor Gombas wrote:

> Also, doing things differently when on AC power smells like a policy
> decision, and AFAIK policy handling is not wanted in the kernel.

Backlight drivers are supposed to return the current brightness. With 
some hardware, the only way to do that requires knowing whether the 
system is on AC or not.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
