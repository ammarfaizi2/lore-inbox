Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUGXDgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUGXDgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268256AbUGXDgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:36:47 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:42429 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S268255AbUGXDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:36:46 -0400
Date: Fri, 23 Jul 2004 22:05:10 -0400
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Mike Wortman <wortman@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: pci_bus_lock question
Message-ID: <20040724020510.GE14905@kroah.com>
References: <1090447841.544.7.camel@sinatra.austin.ibm.com> <1090448467.544.10.camel@sinatra.austin.ibm.com> <20040722070830.GB21907@kroah.com> <1090509081.1648.5.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090509081.1648.5.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 10:11:21AM -0500, John Rose wrote:
> I need to remove a bus from the pci_root_buses() list, and I need to do
> so from a module.  Would it be preferable to export the pci_bus_lock
> symbol or create wrappers in the PCI core that safely add/remove buses
> to/from this list?
> 
> I'm guessing the latter :)

Good guess :)

greg k-h
