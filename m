Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVLANFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVLANFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVLANFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:05:22 -0500
Received: from ns1.suse.de ([195.135.220.2]:42967 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932212AbVLANFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:05:22 -0500
Date: Thu, 1 Dec 2005 14:05:18 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Enabling RDPMC in user space by default
Message-ID: <20051201130518.GD19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com> <20051130033808.GJ19515@wotan.suse.de> <Pine.LNX.4.61.0511292030580.17356@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511292030580.17356@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree that the NMI watchdog is very important, but my main objection is 
> trying to provide a stable interface for this, i would rather see a 
> seperate tool do it (as cumbersome as it may be) even if it meant that 
> the external tool simply did what you intend on doing in the kernel.

But why an external tool when the nmi watchdog needs this anyways?

-Andi
