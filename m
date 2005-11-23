Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKWLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKWLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVKWLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:53:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11277 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750735AbVKWLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:53:08 -0500
Date: Wed, 23 Nov 2005 11:52:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: overlapping resources for platform devices?
Message-ID: <20051123115259.GA9560@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org> <20051116064123.GA31824@kroah.com> <18C975E2-BA90-4595-8C50-63E5CFB9C0A1@kernel.crashing.org> <20051117154925.GA26032@flint.arm.linux.org.uk> <322E3172-BDF9-40BC-A5EC-444C8C33C450@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322E3172-BDF9-40BC-A5EC-444C8C33C450@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:57:40AM -0600, Kumar Gala wrote:
> Any update?

It should be okay, but I'll step back from saying "safe" because
I don't particularly like the insert_resource() concept.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
