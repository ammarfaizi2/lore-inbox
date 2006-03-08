Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWCHCAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWCHCAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWCHCAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:00:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:46013
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964880AbWCHCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:00:49 -0500
Date: Tue, 7 Mar 2006 18:00:28 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308020028.GB26028@kroah.com>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4408CEC8.7040507@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 06:18:32PM -0500, Jeff Garzik wrote:
> I have a similar situation:
> 
> BIOS initializes PCI device to mode A, I need to switch it to mode B. 
> To do this, I must assign a value to an MMIO PCI BAR that was not 
> initialized at boot.
> 
> How to do this?

I really don't know, what kind of device wants to do this?

thanks,

greg k-h
