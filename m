Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVKNWtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKNWtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVKNWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:49:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:12697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932228AbVKNWtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:49:24 -0500
Date: Mon, 14 Nov 2005 14:35:59 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] PCI Error Recovery: header file patch
Message-ID: <20051114223559.GA6058@kroah.com>
References: <20051108234911.GC19593@austin.ibm.com> <20051108235357.GD19593@austin.ibm.com> <20051108161158.51ef0d34@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108161158.51ef0d34@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 04:11:58PM -0800, Stephen Hemminger wrote:
> 
> >  
> > +/** The pci_channel state describes connectivity between the CPU and
> > + *  the pci device.  If some PCI bus between here and the pci device
> > + *  has crashed or locked up, this info is reflected here.
> > + */
> > +typedef int __bitwise pci_channel_state_t;
> 
> Bit operations should be on unsigned not signed value.

Agreed.  I'll wait for Linas to respin these.

thanks,

greg k-h
