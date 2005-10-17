Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVJQUop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVJQUop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJQUop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:44:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:58324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932279AbVJQUoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:44:44 -0400
Date: Mon, 17 Oct 2005 13:44:10 -0700
From: Greg KH <greg@kroah.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051017204410.GA3861@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43539762.2020706@ens-lyon.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:21:54PM +0200, Brice Goglin wrote:
> Le 17.10.2005 00:41, Andrew Morton a ?crit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > 
> > - Lots of i2c, PCI and USB updates
> > 
> > - Large input layer update to convert it all to dynamic input_dev allocation
> > 
> > - Significant x86_64 updates
> > 
> > - MD updates
> > 
> > - Lots of core memory management scalability rework
> 
> Hi Andrew,
> 
> I got the following oops during the boot on my laptop (Compaq Evo N600c).
> .config is attached.
> 
> Regards,
> Brice
> 
> 
> IBM TrackPoint firmware: 0x0b, buttons: 2/3
> input: TPPS/2 IBM TrackPoint//class/input_dev as input2
> hw_random hardware driver 1.0.0 loaded
> NET: Registered protocol family 23
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]

Odd, what userspace program is wanting to see the proc input stuff?

What distro and version of it are you running?

And did this oops happen after init started, or before?

thanks,

greg k-h
