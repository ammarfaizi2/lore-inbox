Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUKPNqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUKPNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKPNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:46:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261732AbUKPNqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:46:08 -0500
Date: Tue, 16 Nov 2004 13:46:07 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2: parport_pc is broken
Message-ID: <20041116134606.GK11738@parcelfarce.linux.theplanet.co.uk>
References: <20041116125842.A20648@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116125842.A20648@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 12:58:43PM +0000, Russell King wrote:
> I'm seeing this with CONFIG_PCI=n (which is fairly common for ARM
> machines):
> 
> drivers/parport/parport_pc.c:3199: error: `parport_init_mode' undeclared (first use in this function)
> drivers/parport/parport_pc.c:3199: error: (Each undeclared identifier is reported only once
> drivers/parport/parport_pc.c:3199: error: for each function it appears in.)
> 
> It seems to have broken with the VT8231 addition on 7 Nov 2004.
> 
> Maybe we need to test kernel builds with CONFIG_PCI=n as part of a
> standard test set?

Will do.  I'm adding ARM to the set as soon as I finish eicon work...
