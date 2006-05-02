Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWEBNOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWEBNOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWEBNOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:14:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9357 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964803AbWEBNOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:14:34 -0400
Date: Tue, 2 May 2006 15:13:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][UPDATE] PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
Message-ID: <20060502131343.GD1677@elf.ucw.cz>
References: <20060428001758.GA18917@kroah.com> <Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On some embedded systems the PCI address for hotplug devices are not only
> known a priori but are required to be at a given PCI address for other
> master in the system to be able to access.

I'm afraid that CONFIG_EMBEDDED is wrong option for this, I'm
afraid. It was supposed to mean "enable memory-saving options".

-- 
Thanks for all the (sleeping) penguins.
