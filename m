Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVCPRRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVCPRRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCPRRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:17:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:35000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262698AbVCPRRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:17:47 -0500
Date: Wed, 16 Mar 2005 09:17:31 -0800
From: Greg KH <greg@kroah.com>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
Message-ID: <20050316171730.GB8602@kroah.com>
References: <4237A5C1.5030709@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4237A5C1.5030709@sbcglobal.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 10:19:29PM -0500, Robert W. Fuller wrote:
> This isn't limited to the ACPI case.  My BIOS is old enough that ACPI is 
> not supported because the kernel can't find RSDP.  I found that the USB 
> works if I boot with "noapic."  This is probably sub-optimal on an SMP 
> machine.  If don't boot with "noapic" I get the following errors:

This is a _very_ old bug/issue.  The "noapic" boot paramater is the
proper fix for such broken hardware.

thanks,

greg k-h
