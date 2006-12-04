Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966435AbWLDUdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966435AbWLDUdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966653AbWLDUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:33:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966435AbWLDUdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:33:37 -0500
Date: Mon, 4 Dec 2006 12:33:08 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: ebiederm@xmission.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/2] x86_64: earlyprintk usb debug device support.
Message-ID: <20061204203308.GA30307@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907280@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907280@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 12:18:30PM -0800, Lu, Yinghai wrote:
> -----Original Message-----
> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
> 
> >arch/x86_64/kernel/early_printk.c |  574
> +++++++++++++++++++++++++++++++++++++
> > drivers/usb/host/ehci.h           |    8 +
> > include/asm-x86_64/fixmap.h       |    1 
> 
> Can you separate usbdebug handle out from early_printk? 

Yeah, at least tear it out of x86-64, so those of us stuck on different
platforms can use this :)

Other than that minor issue, this looks great.  I don't have a x86-64
box set up here at the moment, so I can't test it, but it looks
acceptable at first glance.

thanks,

greg k-h
