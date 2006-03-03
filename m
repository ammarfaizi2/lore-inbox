Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWCCXSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWCCXSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWCCXSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:18:37 -0500
Received: from mail.dvmed.net ([216.237.124.58]:21656 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932465AbWCCXSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:18:36 -0500
Message-ID: <4408CEC8.7040507@garzik.org>
Date: Fri, 03 Mar 2006 18:18:32 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar situation:

BIOS initializes PCI device to mode A, I need to switch it to mode B. 
To do this, I must assign a value to an MMIO PCI BAR that was not 
initialized at boot.

How to do this?

	Jeff



