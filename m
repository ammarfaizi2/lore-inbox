Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTLOXPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTLOXPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:15:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:18864 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264303AbTLOXPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:15:04 -0500
Date: Mon, 15 Dec 2003 15:14:53 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215231453.GM9543@kroah.com>
References: <12InT-wQ-5@gated-at.bofh.it> <135Nw-5gv-3@gated-at.bofh.it> <137wc-q1-23@gated-at.bofh.it> <m3fzflpwxs.fsf@averell.firstfloor.org> <3FDE3A51.7060802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDE3A51.7060802@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 12:48:49AM +0200, Vladimir Kondratiev wrote:
> 
> My fist intention was exactly same as yours, but if all access were done 
> through pci_dev...

Look at 2.6's version of pci_[read|write]_config_*()  :)

(yeah, it's just a wrapper around pci_bus_*() right now, but that's
easier to change if we have to...)

thanks,

greg k-h


