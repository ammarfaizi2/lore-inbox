Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTLOSkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTLOSkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:40:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:3776 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264141AbTLOSko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:40:44 -0500
Date: Mon, 15 Dec 2003 10:40:32 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215184031.GB7128@kroah.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDDBDFE.5020707@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 03:58:22PM +0200, Vladimir Kondratiev wrote:
> I can statically remap only region for existing buses, this will be huge 
> save. It is 1MB per bus, this lead to typical 2-3MB instead of 256. To 
> be sure I can do this, I need to know that new bus can't be added on run 
> time. I don't think it is true, isn't it? Or do we have single point to 
> capture hot plug for new bus?

New busses can be added at run time, remember hotplug PCI systems.

thanks,

greg k-h
